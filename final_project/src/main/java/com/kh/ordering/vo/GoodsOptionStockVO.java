package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GoodsOptionStockVO {
	private int goods_option_no;
	private int goods_option_stock;
}
