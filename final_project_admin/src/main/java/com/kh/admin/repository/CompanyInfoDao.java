package com.kh.admin.repository;

import com.kh.admin.entity.CompanyInfoDto;

public interface CompanyInfoDao {
	public CompanyInfoDto get();

	public void update(CompanyInfoDto companyInfoDto);
}
