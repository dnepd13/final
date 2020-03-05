package com.kh.ordering.repository;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.CategoryDto;
import com.kh.ordering.entity.SellerCategoryDto;

public interface SellerCategoryDao {
	public int categoryCount();
	//판매자 아이디로 번호 가져오기
			int getNo(@RequestParam String seller_id);
	void seller_category_insert(SellerCategoryDto sellerCategoryDto);

	void seller_update_category(SellerCategoryDto sellerCategoryDto);

	void seller_delete_category(SellerCategoryDto sellerCategoryDto);
	
	int category_no(CategoryDto categoryDto);
	
	public List<Integer> seller_category_list(int seller_no);
	
	public List<CategoryDto> seller_category_name_list(List<Integer> list);
	





}
