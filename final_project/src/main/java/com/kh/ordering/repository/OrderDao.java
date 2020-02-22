package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.CartInfoGoodsDto;
import com.kh.ordering.entity.CartInfoOpDto;
import com.kh.ordering.entity.CartOkDto;
import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.vo.CartInfoVO;
import com.kh.ordering.vo.OrderVO;

public interface OrderDao {
	CartInfoDto getCartInfo(String partner_order_id);
	List<CartInfoGoodsDto> getCartInfoGoods(int cart_info_no);
	List<CartInfoOpDto> getCartInfoOp(int cart_info_goods_no);
	OrderVO getOrderVO(String partner_order_id);
	List<GoodsOptionDto> getGoodsOptionDtoList(List<CartInfoOpDto> cartInfoOpDtoList);
	OrderVO getOrderVO(int partner_order_id);
	
	// 주문내역
	List<CartInfoVO> getCartInfoVO(int member_no);
	List<CartOkDto> getOkList(int member_no); // 상품별 구매확정 테이블
	
	// 카테고리번호 기준 판매량 top5
	List<CartInfoVO> getTopSales(int category_no);
}
