package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.DeliveryDto;
import com.kh.ordering.vo.DeliveryVO;

public class DeliveryDaoImpl implements DeliveryDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(DeliveryVO deliveryVO) {
		sqlSession.insert("delivery.insert", deliveryVO);
	}
	
	@Override
	public void delete(int delivery_no) {
		sqlSession.delete("delivery.delete", delivery_no);
	}
	
	@Override
	public DeliveryDto get(int delivery_no) {
		return sqlSession.selectOne("delivery.get", delivery_no);
	}
	
	@Override
	public DeliveryDto get2(int goods_no) {
		return sqlSession.selectOne("delivery.get2", goods_no);
	}
	
	@Override
	public List<DeliveryDto> getList() {
		return sqlSession.selectList("delivery.getList");
	}
}
