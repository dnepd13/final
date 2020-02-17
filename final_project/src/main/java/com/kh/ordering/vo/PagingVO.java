package com.kh.ordering.vo;

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

		private int seller_no;
		private int member_no;
		
		private int goods_no;
}
