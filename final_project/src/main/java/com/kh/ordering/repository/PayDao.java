package com.kh.ordering.repository;

import com.kh.ordering.entity.PayDto;

public interface PayDao {
	void insertReady(PayDto payDto);
}
