package com.kh.ordering.repository;

import com.kh.ordering.entity.CertDto;

public interface CertDao {

	void certregist(CertDto certDto);

	void certdelete(String email);

	boolean certcheck(String email, String cert);



}