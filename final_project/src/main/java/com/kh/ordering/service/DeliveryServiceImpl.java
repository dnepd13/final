package com.kh.ordering.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.repository.DeliveryDao;
import com.kh.ordering.vo.DeliveryVO;

public class DeliveryServiceImpl implements DeliveryService{
	
	@Autowired
	private DeliveryDao deliveryDao;
	
	@Override
	public void insert(DeliveryVO deliveryVO) {
		deliveryDao.insert(deliveryVO);
	}
}
