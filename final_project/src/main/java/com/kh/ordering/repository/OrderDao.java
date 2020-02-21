package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.CartInfoGoodsDto;
import com.kh.ordering.entity.CartInfoOpDto;
import com.kh.ordering.entity.CartOkDto;
import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.vo.OrderVO;

public interface OrderDao {
	CartInfoDto getCartInfo(String partner_order_id);
	List<CartInfoGoodsDto> getCartInfoGoods(int cart_info_no);
	List<CartInfoOpDto> getCartInfoOp(int cart_info_goods_no);
	OrderVO getOrderVO(String partner_order_id);
	List<GoodsOptionDto> getGoodsOptionDtoList(List<CartInfoOpDto> cartInfoOpDtoList);
	OrderVO getOrderVO(int partner_order_id);
	
	// 주문내역
	List<CartInfoGoodsDto> getGoodsList(int member_no); // 상품별 주문내역
	List<CartOkDto> getOkList(int member_no); // 상품별 구매확정 테이블
}
