package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.CartInfoGoodsDto;
import com.kh.ordering.entity.CartInfoOpDto;
import com.kh.ordering.entity.CartOkDto;
import com.kh.ordering.entity.GoodsOptionDto;
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
	
	// 회원 주문내역
	List<CartInfoDto> getCartInfoMember(PagingVO paging);
	int getCartInfoCount(int member_no);
	List<CartInfoVO> getCartGoods(int cart_info_no);
	
	CartOkDto getCartOk(int cart_info_goods_no); // 상품별 구매확정 테이블
	// 구매확정 상태 업데이트
	void updateCartOk(int cart_info_goods_no);
	// 리뷰등록 상태 업데이트
	void updateCartReview(int cart_info_goods_no);
	
	// 카테고리번호 기준 판매량 top5
	List<CartInfoVO> getTopSales(int category_no);
}
