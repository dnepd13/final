package com.kh.ordering.vo;

import java.util.List;

import com.kh.ordering.entity.GoodsDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class GoodsFileVO {
	private GoodsDto goodsDto;
	private int goods_main_image;
}
