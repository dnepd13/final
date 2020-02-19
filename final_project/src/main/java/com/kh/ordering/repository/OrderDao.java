package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.CartInfoGoodsDto;
import com.kh.ordering.entity.CartInfoOpDto;
import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.vo.OrderVO;

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
}
