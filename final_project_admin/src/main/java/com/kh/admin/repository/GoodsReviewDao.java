package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.vo.ReviewVO;

public interface GoodsReviewDao {
	public List<ReviewVO> reviewList(int no);
}
