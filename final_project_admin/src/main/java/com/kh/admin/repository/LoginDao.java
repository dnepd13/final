package com.kh.admin.repository;

import com.kh.admin.entity.AdminDto;

public interface LoginDao {
	AdminDto login(AdminDto adminDto);
}
