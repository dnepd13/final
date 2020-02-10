package com.kh.ordering.repository;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.SellerAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.vo.CustomOrderVO;

public interface SellerDao {
	int getSequence();
	void regist(SellerDto sellerDto);
	
	SellerDto login(SellerDto sellerDto);
	SellerDto info(SellerDto sellerDto);
//	SellerDto info_edit(SellerDto sellerDto);



}
