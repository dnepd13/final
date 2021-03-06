package com.kh.admin.service;

import org.json.simple.JSONObject;

public interface ChartService {
	public JSONObject dailyVisitChart();
	public JSONObject monthlySalePriceChart();
	
	public JSONObject goodsTopTen();
	public JSONObject priceTopTen();
	public JSONObject sellerTopTen();
}
