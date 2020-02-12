package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.vo.GoodsVO;
import com.kh.admin.vo.SellerGoodsVO;

public interface GoodsDao {
	public List<GoodsVO> getGoodsVO();
	public List<SellerGoodsVO> listGoods();
}
