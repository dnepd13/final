package com.kh.admin.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class GoodsDto {
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
}
