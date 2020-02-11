package com.kh.admin.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor 
public class GoodsVO extends BaseVO{
	private int 
					seller_no,
					category_no,
					goods_price,
					goods_discount_price,
					goods_stock;
	private String goods_name,
						goods_discount_start,
						goods_discount_finish,
						goods_status,
						goods_content;
	private List<GoodsOptionVO> goodsOptionVO;
}
