package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.CategoryDto;
import com.kh.ordering.entity.SellerCategoryDto;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class SellerCategoryDaoImpl implements SellerCategoryDao{
	@Autowired
	private SqlSession sqlSession;
	//-------------------------판매자id로 판매자 번호 구하기----------------//
	@Override
	public int getNo(String seller_id) {
		// seller_id 나중에 세션에서 가져와서 바꾸기
		int seller_no = sqlSession.selectOne("seller.getNo", seller_id);
	    return seller_no;
	}
	
	//-------------------------판매자 카테고리 관리----------------//
	@Override
	public int categoryCount() {
		int result= sqlSession.selectOne("seller_category.categoryCount");
		return result;

	}
	//------------------------- 카테고리 등록----------------//
	@Override
	public void seller_category_insert(SellerCategoryDto sellerCategoryDto) {
		log.info("sellerCategoryDto={}", sellerCategoryDto);
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
	//------------------------- 카테고 번호----------------//
	@Override
	public int category_no(CategoryDto categoryDto) {
		
		return 	sqlSession.selectOne("seller_category.get_category_no", categoryDto);
		
	}
	//------------------------- 판매자의 카테고리 리스트----------------//
	@Override
	public List<Integer> seller_category_list(int seller_no) {
		
		return sqlSession.selectList("seller_category.get_category_list", seller_no);
	}
	//-------------------------카테고리 리스트----------------//
	@Override
	public List<CategoryDto> seller_category_name_list(List<Integer> list) {
		
		return sqlSession.selectList("seller_category.get_category_name_list",list);
	}
				
	@Override
	public List<CategoryDto> categoryGetList(PagingVO vo) {
		List<CategoryDto> list =
				sqlSession.selectList("seller_categoty.sellerGetCategoryList",vo);
		return list;
	}

	@Override
	public List<CategoryDto> categoryBig() {		
		return sqlSession.selectList("seller_categoty.categoryItemBig");
	}

	@Override
	public List<CategoryDto> categoryMiddle() {
		return sqlSession.selectList("seller_categoty.categoryItemMiddle");
	}



	@Override
	public List<CategoryDto> categorySmall() {
		return sqlSession.selectList("seller_categoty.categoryItemSmall");
	}

}
	


