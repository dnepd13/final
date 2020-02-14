package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.DeliveryDto;
import com.kh.ordering.vo.DeliveryVO;

public interface DeliveryDao {
	void insert(DeliveryVO deliveryVO);
	void delete(int delivery_no);
	DeliveryDto get(int delivery_no);
	List<DeliveryDto> getList();
	DeliveryDto get2(int goods_no);
}
