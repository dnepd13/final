package com.kh.ordering.vo;

import java.util.List;

import com.kh.ordering.entity.CartInfoGoodsDto;
import com.kh.ordering.entity.CartInfoOpDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CartInfoGoodsVO {
	private CartInfoGoodsDto cartInfoGoodsDto;
	private List<CartInfoOpDto> cartInfoOpDtoList;
}
