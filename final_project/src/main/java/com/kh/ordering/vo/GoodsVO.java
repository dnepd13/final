package com.kh.ordering.vo;

import java.util.List;

import com.kh.ordering.entity.GoodsOptionDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GoodsVO {
	private int goods_no;
	private int seller_no;
	private String goods_name;
	private int goods_price;
	private int goods_discount_price;
	private String goods_discount_start;
	private String goods_discount_finish;
	private int goods_stock;
	private String goods_status;
	private String goods_content;
	private int category_no;
	private List<GoodsOptionDto> goodsOptionList;
}
