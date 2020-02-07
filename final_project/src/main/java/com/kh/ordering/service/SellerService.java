package com.kh.ordering.service;

import com.kh.ordering.entity.SellerDto;

public interface SellerService {
		void regist(SellerDto sellerDto);

		SellerDto login(SellerDto sellerDto);
}
