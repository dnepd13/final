package com.kh.admin.vo;

import java.util.List;

import com.kh.admin.entity.GoodsOptionDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class GoodsVO {
	private int goods_no,
					seller_no,
					goods_price,
					goods_discount_price,
					goods_stock,
					category_no;
	private String goods_name,
						goods_discount_start,
						goods_discount_finish,
						goods_status,
						goods_content;
	private List<GoodsOptionDto> goodsOptionList;
}
