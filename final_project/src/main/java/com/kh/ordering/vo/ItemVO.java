package com.kh.ordering.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ItemVO {
	private int goods_no;
	private List<Integer> option_no_list;
	private int price;
	private int quantity;
}
