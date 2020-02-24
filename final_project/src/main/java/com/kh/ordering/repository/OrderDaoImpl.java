package com.kh.ordering.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.CartInfoGoodsDto;
import com.kh.ordering.entity.CartInfoOpDto;
import com.kh.ordering.entity.CartOkDto;
import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.vo.CartInfoGoodsVO;
import com.kh.ordering.vo.CartInfoVO;
import com.kh.ordering.vo.CartVO;
import com.kh.ordering.vo.OrderDeliveryVO;
import com.kh.ordering.vo.OrderVO;
import com.kh.ordering.vo.PagingVO;

public class OrderDaoImpl implements OrderDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private DeliveryDao deliveryDao;
	
	@Autowired
	private GoodsOptionDao goodsOptionDao;
	
	@Override
	public OrderVO getOrderVO(int partner_order_id) {
		return this.getOrderVO(String.valueOf(partner_order_id));
	}
	
	@Override
	public OrderVO getOrderVO(String partner_order_id) {
		CartInfoDto cartInfoDto = this.getCartInfo(partner_order_id);
		List<CartInfoGoodsDto> cartInfoGoodsDtoList = this.getCartInfoGoods(cartInfoDto.getCart_info_no());
		List<CartInfoGoodsVO> cartInfoGoodsVOList = new ArrayList<>();
		
		for(int i = 0; i < cartInfoGoodsDtoList.size(); i++) {
			List<CartInfoOpDto> cartInfoOpDtoList = this.getCartInfoOp(cartInfoGoodsDtoList.get(i).getCart_info_goods_no());
			CartInfoGoodsVO cartInfoGoodsVO = CartInfoGoodsVO.builder()
					.cartInfoGoodsDto(cartInfoGoodsDtoList.get(i))
					.cartInfoOpDtoList(cartInfoOpDtoList)
					.build();
			cartInfoGoodsVOList.add(cartInfoGoodsVO);
		}
		
		// DB에서 결제내역 가져왔음 orderVO에 넣어줘야함
		
		OrderVO orderVO = new OrderVO();
		
		OrderDeliveryVO orderDeliveryVO = OrderDeliveryVO.builder()
										.delivery_name(cartInfoDto.getDelivery_name())
										.cart_info_addr_post(cartInfoDto.getCart_info_addr_post())
										.cart_info_addr_basic(cartInfoDto.getCart_info_addr_basic())
										.cart_info_addr_extra(cartInfoDto.getCart_info_addr_extra())
										.cart_info_addr_status(cartInfoDto.getCart_info_addr_status())
									.build();
		
		List<CartVO> cartVOList = new ArrayList<>();
		for(CartInfoGoodsVO cartInfoGoodsVO : cartInfoGoodsVOList) {
			CartVO cartVO = CartVO.builder()
					.goodsDto(goodsDao.get(cartInfoGoodsVO.getCartInfoGoodsDto().getGoods_no()))
					.option_list(this.getGoodsOptionDtoList(cartInfoGoodsVO.getCartInfoOpDtoList()))
					.price(cartInfoGoodsVO.getCartInfoGoodsDto().getCart_info_goods_price())
					.quantity(cartInfoGoodsVO.getCartInfoGoodsDto().getCart_info_goods_quantity())
					.deliveryDto(deliveryDao.get2(cartInfoGoodsVO.getCartInfoGoodsDto().getGoods_no()))
				.build();
			cartVOList.add(cartVO);
		}
		
		orderVO.setCartVOList(cartVOList);
		orderVO.setOrderDeliveryVO(orderDeliveryVO);
		orderVO.setUsed_point(cartInfoDto.getUsed_point());
		orderVO.setTotal_quantity(cartInfoDto.getTotal_quantity());
		orderVO.setTotal_price(cartInfoDto.getTotal_price());
		orderVO.setTotal_delivery_price(cartInfoDto.getTotal_delivery_price());
		orderVO.setPartner_user_id(cartInfoDto.getPartner_order_id());
		
		return orderVO;
	}
	
	@Override
	public List<GoodsOptionDto> getGoodsOptionDtoList(List<CartInfoOpDto> cartInfoOpDtoList){
		List<GoodsOptionDto> goodsOptionDtoList = new ArrayList<>();
		for (CartInfoOpDto cartInfoOpDto : cartInfoOpDtoList) {
			goodsOptionDtoList.add(goodsOptionDao.get(cartInfoOpDto.getGoods_option_no()));
		}
		
		return goodsOptionDtoList;
	}
	
	@Override
	public CartInfoDto getCartInfo(String partner_order_id) {
		return sqlSession.selectOne("getCartInfo", partner_order_id);
	}
	
	@Override
	public List<CartInfoGoodsDto> getCartInfoGoods(int cart_info_no) {
		return sqlSession.selectList("getCartInfoGoods", cart_info_no);
	}
	
	@Override
	public List<CartInfoOpDto> getCartInfoOp(int cart_info_goods_no) {
		return sqlSession.selectList("getCartInfoOp", cart_info_goods_no);
	}


	@Override // 회원 주문내역
	public List<CartInfoDto> getCartInfoMember(PagingVO paging) {
		return sqlSession.selectList("order.getCartInfoMember", paging);
	}
	@Override
	public int getCartInfoCount(int member_no) {
		return sqlSession.selectOne("order.getCartInfoCount", member_no);
	}
	@Override // 주문번호에 대한 상품List
	public List<CartInfoVO> getCartGoods(int cart_info_no) {
		return sqlSession.selectList("order.getCartGoods", cart_info_no);
	}

	@Override // 상품별 구매확정 테이블
	public CartOkDto getCartOk(int cart_info_goods_no) {
		return sqlSession.selectOne("order.getOkList", cart_info_goods_no);
	}
	@Override // 구매확정 상태 업데이트
	public void updateCartOk(int cart_info_goods_no) {
		sqlSession.update("order.updateCartOk", cart_info_goods_no);
	}
	@Override // 리뷰등록 상태 업데이트
	public void updateCartReview(int cart_info_goods_no) {
		sqlSession.update("order.updateCartReview", cart_info_goods_no);
	}

	@Override // 카테고리번호 기준 판매량 top5
	public List<CartInfoVO> getTopSales(int category_no) {
		return sqlSession.selectList("order.getTopSales", category_no);
	}

}
