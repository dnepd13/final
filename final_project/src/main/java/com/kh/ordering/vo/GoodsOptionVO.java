package com.kh.ordering.vo;

import java.util.List;

import com.kh.ordering.entity.GoodsOptionDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class GoodsOptionVO {
	private String goods_option_title;
	private List<GoodsOptionDto> goodsOptionList;
}
