package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.CategoryDto;
import com.kh.admin.vo.PagingVO;

public interface CategoryDao {
	public int categoryCount();
	public List<CategoryDto> categoryGetList(PagingVO vo);
	void insertCategory(CategoryDto categoryDto);
	void updateCategory(CategoryDto categoryDto);
	void deleteCategory(int category_no);
	public List<CategoryDto> categoryBig();
	public List<CategoryDto> categoryMiddle();
	public List<CategoryDto> categorySmall();
}
