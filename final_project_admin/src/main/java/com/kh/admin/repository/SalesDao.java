package com.kh.admin.repository;

import java.util.List;

import org.json.simple.JSONObject;

import com.kh.admin.entity.OrderingDto;
import com.kh.admin.vo.ConnectListVO;
import com.kh.admin.vo.ConnectVO;
import com.kh.admin.vo.MonthlySalePriceVO;
import com.kh.admin.vo.ResultVO;
import com.kh.admin.vo.TopTenChartVO;

public interface SalesDao {
	public List<ConnectListVO> connectList();
	public ResultVO dailySalePrice();
	public ResultVO todaySaleCount();
	public ResultVO thisMonthSalePrice();
	public ResultVO thisMonthSaleCount();
	public ResultVO thisWeekSalePrice();
	public ResultVO thisWeekSaleCount();
	public List<MonthlySalePriceVO> monthlySalePriceChart();
	public ResultVO dailyCancel();
	public ResultVO thisWeekCancel();
	public ResultVO thisMonthCancel();
	
	public List<TopTenChartVO> goodsTopTen();
	public List<TopTenChartVO> priceTopTen();
	public List<TopTenChartVO> sellerTopTen();
}
