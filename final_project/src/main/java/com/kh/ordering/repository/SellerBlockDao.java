package com.kh.ordering.repository;

import com.kh.ordering.entity.BlockDto;

public interface SellerBlockDao {
	public BlockDto sellerBlock(String id);
	
	// seller 번호로 블락내용 좀 가져가겠습니다 ...
	BlockDto blockDto(int seller_no);
}
