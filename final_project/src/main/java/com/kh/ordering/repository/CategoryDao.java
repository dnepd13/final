package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.CategoryDto;

public interface CategoryDao {
	void insert(CategoryDto categoryDto);
	void delete(int category_no);
	CategoryDto get(int category_no);
	CategoryDto get(String category_name);
	List<CategoryDto> getList();
	List<String> getList(String type, String category_name);
}
