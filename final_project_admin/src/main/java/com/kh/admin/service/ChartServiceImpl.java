package com.kh.admin.service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.admin.entity.OrderingDto;
import com.kh.admin.repository.SalesDao;
import com.kh.admin.vo.ConnectListVO;
import com.kh.admin.vo.MonthlySalePriceVO;
import com.kh.admin.vo.TopTenChartVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ChartServiceImpl implements ChartService{
	@Autowired
	private SalesDao salesDao;
	
	@Override
	public JSONObject dailyVisitChart() {
		JSONArray ajaxArryCols = new JSONArray();
		JSONObject ajaxObjCols1 = new JSONObject();
		JSONObject ajaxObjCols2 = new JSONObject();
		JSONArray ajaxArryRows = new JSONArray();
		JSONObject data = new JSONObject();
		
		ajaxObjCols1.put("id", "");
		ajaxObjCols1.put("label", "date");
		ajaxObjCols1.put("pattern", "");
		ajaxObjCols1.put("type", "string");
		
		ajaxObjCols2.put("id", "");
		ajaxObjCols2.put("label", "접속자수");
		ajaxObjCols2.put("pattern", "");
		ajaxObjCols2.put("type", "number");
		
		ajaxArryCols.add(ajaxObjCols1);
		ajaxArryCols.add(ajaxObjCols2);
		
		List<ConnectListVO> connectList = salesDao.connectList();
		
		for(int i = 0; i < connectList.size(); i++) {
			JSONObject dailyCount = new JSONObject();
			dailyCount.put("v", connectList.get(i).getDaily());
			dailyCount.put("f", null);
			
			JSONObject dailyValue = new JSONObject();
			dailyValue.put("v", connectList.get(i).getConnecting());
			dailyValue.put("f", null);
			
			JSONArray valuearry = new JSONArray();
			valuearry.add(dailyCount);
			valuearry.add(dailyValue);
			
			JSONObject valueObj = new JSONObject();
			valueObj.put("c", valuearry);
			
			ajaxArryRows.add(valueObj);
		}
		
		data.put("cols", ajaxArryCols);
		data.put("rows", ajaxArryRows);
		return data;
	}

	@Override
	public JSONObject monthlySalePriceChart() {
		JSONArray ajaxArryCols = new JSONArray();
		JSONObject ajaxObjCols1 = new JSONObject();
		JSONObject ajaxObjCols2 = new JSONObject();
		JSONArray ajaxArryRows = new JSONArray();
		JSONObject data = new JSONObject();
		
		ajaxObjCols1.put("id", "");
		ajaxObjCols1.put("label", "날짜");
		ajaxObjCols1.put("pattern", "");
		ajaxObjCols1.put("type", "string");
		
		ajaxObjCols2.put("id", "");
		ajaxObjCols2.put("label", "판매금액");
		ajaxObjCols2.put("pattern", "");
		ajaxObjCols2.put("type", "number");
		
		ajaxArryCols.add(ajaxObjCols1);
		ajaxArryCols.add(ajaxObjCols2);
		
		List<MonthlySalePriceVO> monthlySalePrice = salesDao.monthlySalePriceChart();
		log.info("monthlySalePrice={}", monthlySalePrice);
		for(int i = 0; i < monthlySalePrice.size(); i++) {
			JSONObject dailyCount = new JSONObject();
			dailyCount.put("v", monthlySalePrice.get(i).getProcess_time());
			dailyCount.put("f", null);
			
			JSONObject dailyValue = new JSONObject();
			dailyValue.put("v", monthlySalePrice.get(i).getTotal_amount());
			dailyValue.put("f", null);
			
			JSONArray valuearry = new JSONArray();
			valuearry.add(dailyCount);
			valuearry.add(dailyValue);
			
			JSONObject valueObj = new JSONObject();
			valueObj.put("c", valuearry);
			
			ajaxArryRows.add(valueObj);
		}
		
		data.put("cols", ajaxArryCols);
		data.put("rows", ajaxArryRows);
		log.info("data={}", data);
		return data;
	}

	@Override
	public JSONObject goodsTopTen() {
		log.info("여기2");
		JSONArray ajaxArryCols = new JSONArray();
		JSONObject ajaxObjCols1 = new JSONObject();
		JSONObject ajaxObjCols2 = new JSONObject();
		JSONArray ajaxArryRows = new JSONArray();
		JSONObject data = new JSONObject();
		
		ajaxObjCols1.put("id", "");
		ajaxObjCols1.put("label", "상품");
		ajaxObjCols1.put("pattern", "");
		ajaxObjCols1.put("type", "string");
		
		ajaxObjCols2.put("id", "");
		ajaxObjCols2.put("label", "개");
		ajaxObjCols2.put("pattern", "");
		ajaxObjCols2.put("type", "number");
		
		ajaxArryCols.add(ajaxObjCols1);
		ajaxArryCols.add(ajaxObjCols2);
		
		List<TopTenChartVO> connectList = salesDao.goodsTopTen();
		log.info("여기3");
		for(int i = 0; i < connectList.size(); i++) {
			JSONObject dailyCount = new JSONObject();
			dailyCount.put("v", connectList.get(i).getItem());
			dailyCount.put("f", null);
			
			JSONObject dailyValue = new JSONObject();
			dailyValue.put("v", connectList.get(i).getResult());
			dailyValue.put("f", null);
			
			JSONArray valuearry = new JSONArray();
			valuearry.add(dailyCount);
			valuearry.add(dailyValue);
			
			JSONObject valueObj = new JSONObject();
			valueObj.put("c", valuearry);
			
			ajaxArryRows.add(valueObj);
		}
		log.info("여기4");
		data.put("cols", ajaxArryCols);
		data.put("rows", ajaxArryRows);
		return data;
	}

	@Override
	public JSONObject priceTopTen() {
		log.info("여기2");
		JSONArray ajaxArryCols = new JSONArray();
		JSONObject ajaxObjCols1 = new JSONObject();
		JSONObject ajaxObjCols2 = new JSONObject();
		JSONArray ajaxArryRows = new JSONArray();
		JSONObject data = new JSONObject();
		
		ajaxObjCols1.put("id", "");
		ajaxObjCols1.put("label", "상품");
		ajaxObjCols1.put("pattern", "");
		ajaxObjCols1.put("type", "string");
		
		ajaxObjCols2.put("id", "");
		ajaxObjCols2.put("label", "금액");
		ajaxObjCols2.put("pattern", "");
		ajaxObjCols2.put("type", "number");
		
		ajaxArryCols.add(ajaxObjCols1);
		ajaxArryCols.add(ajaxObjCols2);
		
		List<TopTenChartVO> connectList = salesDao.priceTopTen();
		log.info("여기3");
		for(int i = 0; i < connectList.size(); i++) {
			JSONObject dailyCount = new JSONObject();
			dailyCount.put("v", connectList.get(i).getItem());
			dailyCount.put("f", null);
			
			JSONObject dailyValue = new JSONObject();
			dailyValue.put("v", connectList.get(i).getResult());
			dailyValue.put("f", null);
			
			JSONArray valuearry = new JSONArray();
			valuearry.add(dailyCount);
			valuearry.add(dailyValue);
			
			JSONObject valueObj = new JSONObject();
			valueObj.put("c", valuearry);
			
			ajaxArryRows.add(valueObj);
		}
		log.info("여기4");
		data.put("cols", ajaxArryCols);
		data.put("rows", ajaxArryRows);
		return data;
	}

	@Override
	public JSONObject sellerTopTen() {
		JSONArray ajaxArryCols = new JSONArray();
		JSONObject ajaxObjCols1 = new JSONObject();
		JSONObject ajaxObjCols2 = new JSONObject();
		JSONArray ajaxArryRows = new JSONArray();
		JSONObject data = new JSONObject();
		
		ajaxObjCols1.put("id", "");
		ajaxObjCols1.put("label", "판매자");
		ajaxObjCols1.put("pattern", "");
		ajaxObjCols1.put("type", "string");
		
		ajaxObjCols2.put("id", "");
		ajaxObjCols2.put("label", "개");
		ajaxObjCols2.put("pattern", "");
		ajaxObjCols2.put("type", "number");
		
		ajaxArryCols.add(ajaxObjCols1);
		ajaxArryCols.add(ajaxObjCols2);
		
		List<TopTenChartVO> connectList = salesDao.sellerTopTen();
		log.info("여기3");
		for(int i = 0; i < connectList.size(); i++) {
			JSONObject dailyCount = new JSONObject();
			dailyCount.put("v", connectList.get(i).getItem());
			dailyCount.put("f", null);
			
			JSONObject dailyValue = new JSONObject();
			dailyValue.put("v", connectList.get(i).getResult());
			dailyValue.put("f", null);
			
			JSONArray valuearry = new JSONArray();
			valuearry.add(dailyCount);
			valuearry.add(dailyValue);
			
			JSONObject valueObj = new JSONObject();
			valueObj.put("c", valuearry);
			
			ajaxArryRows.add(valueObj);
		}
		log.info("여기4");
		data.put("cols", ajaxArryCols);
		data.put("rows", ajaxArryRows);
		return data;
	}
	
}
