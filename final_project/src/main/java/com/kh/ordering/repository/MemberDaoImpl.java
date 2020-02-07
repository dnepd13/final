package com.kh.ordering.repository;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;

//	회원id로 회원번호 구하기
	@Override
	public int MemberNo(String member_id) {
		// member_id 나중에 HttpSession의 session.getAttribute로 바꾸기
		int member_no = sqlSession.selectOne("member.getNo", member_id);
		return member_no;
	}
	
//	Member 요청서 작성
	@Override // 요청서 저장
	public void CustomOrderInsert(CustomOrderDto customOrderDto) {
		sqlSession.insert("member.customReq", customOrderDto);
	}
	
	@Override // 요청서 관리 저장
	public void MemberCustom(MemberCustomOrderDto memberCustomDto) {	
		sqlSession.insert("member.customInsert", memberCustomDto);
	}

	@Override //요청서 시퀀스
	public int CustomSeq() {
		
		return sqlSession.selectOne("member.customSeq");
	}

	@Override // 판매자가 보낸 견적서 보기
	public List<CustomOrderDto> getListCustom() {
		
		return sqlSession.selectList("member.getListCustom");
	}

	@Override // 내가 보낸 요청서 보기
	public List<CustomOrderDto> getListReq(int member_no) {
		
		return sqlSession.selectList("member.getListReq", member_no);
	}

}
