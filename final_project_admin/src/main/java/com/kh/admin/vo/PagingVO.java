package com.kh.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PagingVO {
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
		public String seller_id;
		public int year, month;
}
