package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.CategoryDto;
import com.kh.ordering.entity.SellerCategoryDto;
import com.kh.ordering.entity.SellerDto;

public interface CategoryDao {
	void insert(CategoryDto categoryDto);
	void delete(int category_no);
	CategoryDto get(int category_no);
	CategoryDto get(String category_name);
	List<CategoryDto> getList();
	List<String> getList(String type, String category_name);
	
	// 카테고리 번호로 판매자 no 검색
	List<SellerCategoryDto> getSellerNo(int category_no);
}
