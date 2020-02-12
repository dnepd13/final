package com.kh.ordering.vo;

import java.util.List;

import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.entity.GoodsOptionDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CartVO {
	private GoodsDto goodsDto;
	private List<GoodsOptionDto> option_list;
	private int price;
	private int quantity;
}
