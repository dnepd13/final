package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.CategoryDto;
import com.kh.ordering.entity.SellerCategoryDto;
import com.kh.ordering.entity.SellerDto;

public class CategoryDaoImpl implements CategoryDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(CategoryDto categoryDto) {
		sqlSession.insert("category.insert", categoryDto);
	}
	
	@Override
	public void delete(int category_no) {
		sqlSession.delete("category.delete", category_no);
	}
	
	@Override
	public CategoryDto get(int category_no) {
		return sqlSession.selectOne("category.get", category_no);
	}
	
	@Override
	public CategoryDto get(String category_name) {
		return sqlSession.selectOne("category.getCategoryNo", category_name);
	}
	
	@Override
	public List<CategoryDto> getList() {
		return sqlSession.selectList("category.getList");
	}
	
	@Override
	public List<String> getList(String type, String category_name) {
		
		switch (type) {
		case "category_large": return sqlSession.selectList("category.searchLarge");
		case "category_middle": return sqlSession.selectList("category.searchMiddle", category_name);	
		case "category_small": return sqlSession.selectList("category.searchSmall", category_name);
		default:
			return null;
		}
		
	}

	@Override // 카테고리 번호로 판매자 List 검색
	public List<SellerCategoryDto> getSellerNo(int category_no) {
		return sqlSession.selectList("category.getSellerNo", category_no);
	}

	@Override
	public List<SellerDto> getSeller(int category_no) {
		return sqlSession.selectList("category.getSeller", category_no);
	}

}
