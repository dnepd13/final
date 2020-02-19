package com.kh.admin.repository;

import java.util.List;

import org.json.simple.JSONObject;

import com.kh.admin.vo.ConnectListVO;
import com.kh.admin.vo.ConnectVO;

public interface SalesDao {
	public List<ConnectListVO> connectList();
}
