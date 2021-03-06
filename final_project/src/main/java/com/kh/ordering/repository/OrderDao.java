package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.CartInfoGoodsDto;
import com.kh.ordering.entity.CartInfoOpDto;
import com.kh.ordering.entity.CartOkDto;
import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.entity.PayDto;
import com.kh.ordering.vo.CartDetailsVO;
import com.kh.ordering.vo.CartInfoVO;
import com.kh.ordering.vo.OrderVO;
import com.kh.ordering.vo.PagingVO;

public interface OrderDao {
	CartInfoDto getCartInfo(String partner_order_id);
	List<CartInfoGoodsDto> getCartInfoGoods(int cart_info_no);
	List<CartInfoOpDto> getCartInfoOp(int cart_info_goods_no);
	OrderVO getOrderVO(String partner_order_id);
	List<GoodsOptionDto> getGoodsOptionDtoList(List<CartInfoOpDto> cartInfoOpDtoList);
	OrderVO getOrderVO(int partner_order_id);
	int getMember_no(String partner_order_id);
	int getOrdering_no(String partner_order_id);
	boolean updatePointAndStock(String partner_order_id) throws Exception;
	int getCartInfoNo(String partner_order_id);
	
	// 회원 주문내역
	List<CartInfoDto> getCartInfoMember(PagingVO paging);
	int getCartInfoCount(int member_no);
	CartInfoDto getCartInfoDto(int cart_info_no);
	List<CartInfoVO> getCartPay(String partner_order_id); // 결제상세
	List<CartDetailsVO> getCartGoods(int cart_info_no); // 상품상세
	List<CartDetailsVO> getCartOption(int cart_info_goods_no); // 옵션상세
	
	// 주문제작 결제 후 상세내용 단일조회
	CustomOrderDto getCustomOrderDto (int custom_order_no);
	
	CartOkDto getCartOk(int cart_info_goods_no); // 상품별 구매확정 테이블
	// 구매확정 상태 업데이트
	void updateCartOk(int cart_info_goods_no);
	// 리뷰등록 상태 업데이트
	void updateCartReview(int cart_info_goods_no);
	
	// 카테고리번호 기준 판매량 top5 판매자 조회
	List<CartInfoVO> getTopSales(int category_no);

	// 회원 마이페이지 메인: 최근 3일 주문내역 5개
	List<PayDto> getListYesterDay(int member_no);
}
