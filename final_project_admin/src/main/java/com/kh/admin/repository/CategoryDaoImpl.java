    package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.CategoryDto;
import com.kh.admin.vo.PagingVO;

@Repository
public class CategoryDaoImpl implements CategoryDao{
	
	@Autowired
	private SqlSession sqlSession;
	@Override
	public int categoryCount() {
		int result = sqlSession.selectOne("admin.categoryCount");
		return result;
	}
	@Override
	public List<CategoryDto> categoryGetList(PagingVO vo) {
		List<CategoryDto> list = sqlSession.selectList("admin.sellerGetCategoryList", vo);
		return list;
	}
	@Override
	public void insertCategory(CategoryDto categoryDto) {
		sqlSession.insert("admin.categoryInsert", categoryDto);
	}
	@Override
	public void updateCategory(CategoryDto categoryDto) {
		sqlSession.update("admin.categoryUpdate", categoryDto);
	}
	@Override
	public void deleteCategory(int category_no) {
		sqlSession.delete("admin.categoryDelete", category_no);
	}
}
