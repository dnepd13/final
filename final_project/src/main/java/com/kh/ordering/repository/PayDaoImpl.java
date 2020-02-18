package com.kh.ordering.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.CartInfoGoodsDto;
import com.kh.ordering.entity.CartInfoOpDto;
import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.entity.PayDto;
import com.kh.ordering.vo.CartVO;
import com.kh.ordering.vo.OrderVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PayDaoImpl implements PayDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public String getItem_name(OrderVO orderVO) {
		String item_name = orderVO.getCartVOList().get(0).getGoodsDto().getGoods_name();
		StringBuffer buffer = new StringBuffer();
		
		buffer.append(item_name);
		// 상품이 여러개일 경우
		if(orderVO.getCartVOList().size() > 1) {
			buffer.append(" 외 ");
			buffer.append(orderVO.getCartVOList().size());
			buffer.append("건");
		}
		
		return buffer.toString();
	}
	
	// orderVO -> cart_info, cart_info_goods, cart_info_op에 저장
	@Override
	public void insertReady(PayDto payDto, OrderVO orderVO) {
		sqlSession.insert("pay.ready",payDto);
//		int ordering_no = sqlSession.selectOne("pay.getSequenceOrdering");
		// orderVO 3개로 쪼개서 집어넣기
		// cart_info, cart_info_goods, cart_info_op
		
		// # cart_info
		int cart_info_no = sqlSession.selectOne("pay.getSequenceCartInfo");
		CartInfoDto cartInfoDto = CartInfoDto.builder()
									.cart_info_no(cart_info_no)
									.member_no(payDto.getMember())
									.non_no(0)
									.delivery_name(orderVO.getOrderDeliveryVO().getDelivery_name())
									.cart_info_addr_post(orderVO.getOrderDeliveryVO().getCart_info_addr_post())
									.cart_info_addr_basic(orderVO.getOrderDeliveryVO().getCart_info_addr_basic())
									.cart_info_addr_extra(orderVO.getOrderDeliveryVO().getCart_info_addr_extra())
									.cart_info_addr_status(orderVO.getOrderDeliveryVO().getCart_info_addr_status())
									.used_point(orderVO.getUsed_point())
									.total_quantity(orderVO.getTotal_quantity())
									.total_price(orderVO.getTotal_price())
									.total_delivery_price(orderVO.getTotal_delivery_price())
									.partner_order_id(payDto.getPartner_order_id())
									.cart_info_status("결제준비완료")
								.build();
		
		List<CartVO> cartVOList = orderVO.getCartVOList();
		List<CartInfoGoodsDto> cartInfoGoodsList = new ArrayList<>();
		List<CartInfoOpDto> cartInfoOpList = new ArrayList<>();
		
		// # cart_info_goods
		for (CartVO cartVO : cartVOList) {
			int cart_info_goods_no = sqlSession.selectOne("pay.getSequenceGoods");
			CartInfoGoodsDto cartInfoGoodsDto = CartInfoGoodsDto.builder()
						.cart_info_goods_no(cart_info_goods_no)
						.cart_info_no(cartInfoDto.getCart_info_no())
						.goods_no(cartVO.getGoodsDto().getGoods_no())
						.cart_info_goods_quantity(cartVO.getQuantity())
						.cart_info_goods_price(cartVO.getPrice())
					.build();
			cartInfoGoodsList.add(cartInfoGoodsDto);
			
		// # cart_info_op
			for(GoodsOptionDto goodsOptionDto : cartVO.getOption_list()) {
				CartInfoOpDto cartInfoOpDto = CartInfoOpDto.builder()
						.cart_info_goods_no(cart_info_goods_no)
						.goods_option_no(goodsOptionDto.getGoods_option_no())
					.build();
				cartInfoOpList.add(cartInfoOpDto);
			}
		}
		
		sqlSession.insert("pay.insertCartInfo", cartInfoDto);
		sqlSession.insert("pay.insertCartInfoGoods", cartInfoGoodsList);
		sqlSession.insert("pay.insertCartInfoOp", cartInfoOpList);
	}
	@Override
	public void insertSuccess(PayDto payDto) {
		sqlSession.insert("pay.success", payDto);
		// 주문번호로 
		// cart_info 테이블 status update 할 것
		sqlSession.update("pay.updateStatus",payDto.getPartner_order_id());
	}
	@Override
	public List<PayDto> getList() {
		return sqlSession.selectList("pay.list");
	}
	@Override
	public PayDto get(int no) {
		return sqlSession.selectOne("pay.get", no);
	}
	@Override
	public void insertRevoke(PayDto payDto2) {
		sqlSession.insert("pay.revoke", payDto2);
	}
	
	@Override
	public String getPartnerOrderId() {
		return sqlSession.selectOne("pay.getPartnerOrderId").toString() ;
	}
	
	public OrderVO getOrderVO(String partner_order_id) {
		return null;
	}
}
