package com.kh.ordering.repository;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.CertDto;
import com.kh.ordering.repository.CertDao;

public class CertDaoImpl implements CertDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void certregist(CertDto certDto) {
		sqlSession.insert("cert.certregist", certDto);
	}

	@Override
	public void certdelete(String email) {
		sqlSession.delete("cert.certdelete", email);
	}

	@Override
	public boolean certcheck(String email, String cert) {
		Map<String, Object> param = new HashMap<>();
		param.put("email",email);
		param.put("cert_no",cert);
		CertDto certDto = sqlSession.selectOne("cert.certcheck", param);

		return certDto != null;
	}



}