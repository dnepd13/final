package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.PayDto;
import com.kh.ordering.vo.OrderVO;

public interface PayDao {
	void insertReady(PayDto payDto, OrderVO orderVO);

	void insertSuccess(PayDto payDto);

	public List<PayDto> getList();

	PayDto get(int no);

	void insertRevoke(PayDto payDto2);
	
	String getItem_name(OrderVO orderVO);

	String getPartnerOrderId();
	
}
