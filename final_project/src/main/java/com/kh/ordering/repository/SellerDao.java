package com.kh.ordering.repository;

import com.kh.ordering.entity.SellerDto;

public interface SellerDao {
	int getSequence();
	void regist(SellerDto sellerDto);
	
	SellerDto login(SellerDto sellerDto);
	SellerDto info(SellerDto sellerDto);
//	SellerDto info_edit(SellerDto sellerDto);



}
