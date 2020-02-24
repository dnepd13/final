package com.kh.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class AdjustmentVO {
	private String seller_id;
	private int total_delivery_price,
					total_cal_price,
					fee,
					rate,
					adjustment_price;
}
