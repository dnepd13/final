package com.kh.ordering.service;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.vo.FilesVO;

public interface GoodsReviewService {
	GoodsReviewDto insertReview(HttpSession session, FilesVO files,
															int cart_info_no,
															GoodsReviewDto goodsReviewDto)
															throws IllegalStateException, IOException;
}
