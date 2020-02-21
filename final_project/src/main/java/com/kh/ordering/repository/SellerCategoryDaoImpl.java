package com.kh.ordering.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.CategoryDto;
import com.kh.ordering.entity.SellerCategoryDto;

public class SellerCategoryDaoImpl implements SellerCategoryDao{
	@Autowired
	private SqlSession sqlSession;
	
	//-------------------------판매자 카테고리 관리----------------//
	@Override
	public int categoryCount() {
		int result = sqlSession.selectOne("seller_category_count");
		return result;
	}
	//------------------------- 카테고리 등록----------------//
	@Override
	public void seller_category_insert(SellerCategoryDto sellerCategoryDto) {
		sqlSession.insert("seller_category.insert", sellerCategoryDto);

		
	}
	//------------------------- 카테고리 수정----------------//
	@Override
	public void seller_update_category(SellerCategoryDto sellerCategoryDto) {
	sqlSession.update("seller_category.update", sellerCategoryDto);
		
	}
	//------------------------- 카테고리 삭제----------------//
	@Override
	public void seller_delete_category(SellerCategoryDto sellerCategoryDto) {
		sqlSession.delete("seller_category.delete", sellerCategoryDto);
		
	}
	@Override
	public int category_no(CategoryDto categoryDto) {
		
		return 	sqlSession.selectOne("seller_category.get_category_no", categoryDto);
		
	}

}
