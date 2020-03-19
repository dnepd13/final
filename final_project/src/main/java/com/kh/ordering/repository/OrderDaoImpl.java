package com.kh.ordering.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.CartInfoGoodsDto;
import com.kh.ordering.entity.CartInfoOpDto;
import com.kh.ordering.entity.CartOkDto;
import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.entity.PayDto;
import com.kh.ordering.service.payService;
import com.kh.ordering.vo.CartDetailsVO;
import com.kh.ordering.vo.CartInfoGoodsVO;
import com.kh.ordering.vo.CartInfoVO;
import com.kh.ordering.vo.CartVO;
import com.kh.ordering.vo.OrderDeliveryVO;
import com.kh.ordering.vo.OrderVO;
import com.kh.ordering.vo.PagingVO;

public class OrderDaoImpl implements OrderDao {

	@Autowired
	private payService payService;
	
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private GoodsDao goodsDao;

	@Autowired
	private OrderDao orderDao;

	@Autowired
	private DeliveryDao deliveryDao;

	@Autowired
	private GoodsOptionDao goodsOptionDao;

	@Override
	public OrderVO getOrderVO(int partner_order_id) {
		return this.getOrderVO(String.valueOf(partner_order_id));
	}

	@Transactional
	@Override
	public boolean updatePointAndStock(String partner_order_id) throws Exception {

		// 처리 실패시 취소로 보내버리기
		// ### 처리할것들
		// - 주문번호로 상품검색해서 상품 수량 차감 (차감안되면 취소로 보내기)
		// - 상품번호로 검색해서 옵션 수량 차감 (차감안되면 취소로 보내기)

		// 맴버번호, 총가격, 상품번호, 옵션번호,
		// orderVO 필요

		// 주문번호 저장, 회원번호 저장
		int member_no = orderDao.getMember_no(partner_order_id);

		// 주문번호로 결제내역 가져오기
		OrderVO orderVO = orderDao.getOrderVO(partner_order_id);

		//////////////////////////////////////////////////////////////////////////////////////////////
		
		
		
		// 상품+옵션 수량검사, 감소
		List<CartVO> cartVOList = orderVO.getCartVOList();
		for (CartVO cartVO : cartVOList) {
			int stock = cartVO.getQuantity();
			List<GoodsOptionDto> goodsOptionDtoList = cartVO.getOption_list();

			// 옵션 수량 감소
			for (GoodsOptionDto goodsOptionDto : goodsOptionDtoList) {
				if (!goodsOptionDao.minusStock(goodsOptionDto.getGoods_option_no(), stock)) {
					payService.revoke(orderDao.getOrdering_no(partner_order_id));
					System.out.println("옵션수량부족");
					throw new Exception();
				}
			}

			// 상품 수량 감소
			if (!goodsDao.minusStock(cartVO.getGoodsDto().getGoods_no(), stock)) {
				payService.revoke(orderDao.getOrdering_no(partner_order_id));
				System.out.println("상품수량부족");
				throw new Exception();
			}
		}

		// 포인트 검사, 감소
		if (!memberDao.minusPointOrder(member_no, orderVO.getUsed_point())) {
			payService.revoke(orderDao.getOrdering_no(partner_order_id));
			System.out.println("포인트부족");
			throw new Exception();
		}
		
		// 상품 구매 포인트 적용
		memberDao.registOrderPoint(member_no, orderVO.getTotal_price());
		
		// 구매확정 테이블 추가
//		CartOkDto cartOkDto = CartOkDto.
//		memberDao.insertCartOK(cartOkDto);
		
		return true;
	}

	@Override
	public OrderVO getOrderVO(String partner_order_id) {
		CartInfoDto cartInfoDto = this.getCartInfo(partner_order_id);
		List<CartInfoGoodsDto> cartInfoGoodsDtoList = this.getCartInfoGoods(cartInfoDto.getCart_info_no());
		List<CartInfoGoodsVO> cartInfoGoodsVOList = new ArrayList<>();

		for (int i = 0; i < cartInfoGoodsDtoList.size(); i++) {
			List<CartInfoOpDto> cartInfoOpDtoList = this
					.getCartInfoOp(cartInfoGoodsDtoList.get(i).getCart_info_goods_no());
			CartInfoGoodsVO cartInfoGoodsVO = CartInfoGoodsVO.builder().cartInfoGoodsDto(cartInfoGoodsDtoList.get(i))
					.cartInfoOpDtoList(cartInfoOpDtoList).build();
			cartInfoGoodsVOList.add(cartInfoGoodsVO);
		}

		// DB에서 결제내역 가져왔음 orderVO에 넣어줘야함

		OrderVO orderVO = new OrderVO();

		OrderDeliveryVO orderDeliveryVO = OrderDeliveryVO.builder().delivery_name(cartInfoDto.getDelivery_name())
				.cart_info_addr_post(cartInfoDto.getCart_info_addr_post())
				.cart_info_addr_basic(cartInfoDto.getCart_info_addr_basic())
				.cart_info_addr_extra(cartInfoDto.getCart_info_addr_extra())
				.cart_info_addr_status(cartInfoDto.getCart_info_addr_status()).build();

		List<CartVO> cartVOList = new ArrayList<>();
		for (CartInfoGoodsVO cartInfoGoodsVO : cartInfoGoodsVOList) {
			CartVO cartVO = CartVO.builder().goodsDto(goodsDao.get(cartInfoGoodsVO.getCartInfoGoodsDto().getGoods_no()))
					.option_list(this.getGoodsOptionDtoList(cartInfoGoodsVO.getCartInfoOpDtoList()))
					.price(cartInfoGoodsVO.getCartInfoGoodsDto().getCart_info_goods_price())
					.quantity(cartInfoGoodsVO.getCartInfoGoodsDto().getCart_info_goods_quantity())
					.deliveryDto(deliveryDao.get2(cartInfoGoodsVO.getCartInfoGoodsDto().getGoods_no())).build();
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
	public List<GoodsOptionDto> getGoodsOptionDtoList(List<CartInfoOpDto> cartInfoOpDtoList) {
		List<GoodsOptionDto> goodsOptionDtoList = new ArrayList<>();
		for (CartInfoOpDto cartInfoOpDto : cartInfoOpDtoList) {
			goodsOptionDtoList.add(goodsOptionDao.get(cartInfoOpDto.getGoods_option_no()));
		}

		return goodsOptionDtoList;
	}
	
	@Override
	public int getCartInfoNo(String partner_order_id) {
		return sqlSession.selectOne("order.getCartInfoNo", partner_order_id);
	}
	
	@Override
	public int getOrdering_no(String partner_order_id) {
		return sqlSession.selectOne("order.getOrdering_no", partner_order_id);
	}

	@Override
	public int getMember_no(String partner_order_id) {
		return sqlSession.selectOne("order.getMember_no", partner_order_id);
	}

	@Override
	public CartInfoDto getCartInfo(String partner_order_id) {
		return sqlSession.selectOne("order.getCartInfo", partner_order_id);
	}

	@Override
	public List<CartInfoGoodsDto> getCartInfoGoods(int cart_info_no) {
		return sqlSession.selectList("order.getCartInfoGoods", cart_info_no);
	}

	@Override
	public List<CartInfoOpDto> getCartInfoOp(int cart_info_goods_no) {
		return sqlSession.selectList("order.getCartInfoOp", cart_info_goods_no);
	}


	@Override // 회원 주문내역
	public List<CartInfoDto> getCartInfoMember(PagingVO paging) {
		return sqlSession.selectList("order.getCartInfoMember", paging);
	}
	@Override
	public int getCartInfoCount(int member_no) {
		return sqlSession.selectOne("order.getCartInfoCount", member_no);
		
	}
	@Override
	public CartInfoDto getCartInfoDto(int cart_info_no) {
		return sqlSession.selectOne("order.getCartInfoDto", cart_info_no);
	}
	@Override // 결제상세
	public List<CartInfoVO> getCartPay(String partner_order_id) {
		return sqlSession.selectList("order.getCartPay", partner_order_id);
	}
	@Override // 주문번호에 대한 상품 상세
	public List<CartDetailsVO> getCartGoods(int cart_info_no) {
		return sqlSession.selectList("order.getCartGoods", cart_info_no);
	}
	@Override // 옵션상세
	public List<CartDetailsVO> getCartOption(int cart_info_goods_no) {
		return sqlSession.selectList("order.getCartOption", cart_info_goods_no);
	}

	@Override // 주문제작 상세
	public CustomOrderDto getCustomOrderDto(int custom_order_no) {
		return sqlSession.selectOne("order.getCustomOrder", custom_order_no);
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

	@Override // 회원 마이페이지 메인: 최근 3일 주문내역 5개
	public List<PayDto> getListYesterDay(int member_no) {
		return sqlSession.selectList("order.getListYesterDay", member_no);
	}
	
}
