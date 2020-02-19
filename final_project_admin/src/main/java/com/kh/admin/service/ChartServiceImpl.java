package com.kh.admin.service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.admin.repository.SalesDao;
import com.kh.admin.vo.ConnectListVO;

@Service
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
		ajaxObjCols2.put("label", "value");
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
	
}
