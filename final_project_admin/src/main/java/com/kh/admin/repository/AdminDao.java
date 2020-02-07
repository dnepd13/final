package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.entity.AdminQnaBoardDto;
import com.kh.admin.entity.CategoryDto;

public interface AdminDao {
	AdminDto login(AdminDto adminDto);
	void regist(AdminDto adminDto);
	void lastLogin(AdminDto adminDto);
	
}
