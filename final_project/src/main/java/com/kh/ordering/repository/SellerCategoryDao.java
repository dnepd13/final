package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.CategoryDto;
import com.kh.ordering.entity.SellerCategoryDto;

public interface SellerCategoryDao {
	public int categoryCount();
	void seller_category_insert(SellerCategoryDto sellerCategoryDto);

	void seller_update_category(SellerCategoryDto sellerCategoryDto);

	void seller_delete_category(SellerCategoryDto sellerCategoryDto);
	
	int category_no(CategoryDto categoryDto);
	
	public List<Integer> seller_category_list(int seller_no);
	
	public List<CategoryDto> seller_category_name_list(List<Integer> list);
	





}
