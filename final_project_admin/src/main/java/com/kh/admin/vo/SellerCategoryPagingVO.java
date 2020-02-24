package com.kh.admin.vo;

import com.kh.admin.vo.PagingVO.PagingVOBuilder;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class SellerCategoryPagingVO {
	private int pno, 
	count,
	pagesize,
	navsize;
public int pagecount;
public int startBlock;
public int finishBlock;
public int start;
public int finish;
public int member_no;
public String key,
		search;
}
