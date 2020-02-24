package com.kh.ordering.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PageVo {

	//회원 문의 게시판 VO
	private int pno,
				count,
				pagesize,
				navsize,
				pagecount,
				startblock,
				finishblock,
				start,
				finish,
				member_no;
}