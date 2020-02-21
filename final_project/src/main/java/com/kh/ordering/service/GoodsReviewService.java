package com.kh.ordering.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.vo.FilesVO;

public interface GoodsReviewService {
	GoodsReviewDto insertReview(HttpSession session, FilesVO files,
															int cart_info_no,
															GoodsReviewDto goodsReviewDto)
															throws IllegalStateException, IOException;
	List<FilesVO> filesList(int goods_review_no); //파일 출력을 위한 파일no
}
