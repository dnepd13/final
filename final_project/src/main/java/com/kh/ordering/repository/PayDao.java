package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.PayDto;

public interface PayDao {
	void insertReady(PayDto payDto);

	void insertSuccess(PayDto payDto);

	public List<PayDto> getList();

	PayDto get(int no);

	void insertRevoke(PayDto payDto2);
}
