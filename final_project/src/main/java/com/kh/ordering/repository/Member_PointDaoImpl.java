package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.Member_PointDto;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class Member_PointDaoImpl implements Member_PointDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int MemberGetSeq() {
		
		return sqlSession.selectOne("member_PointDto.MemberGetSeq");
	}

	@Override
	public void pointregist(Member_PointDto member_PointDto) {
		sqlSession.insert("member_PointDto.pointregist", member_PointDto);
		
	}



	@Override
	public List<Member_PointDto> getListPoint(PagingVO pagingVO) {

		return sqlSession.selectList("member_PointDto.getListPoint",pagingVO);
	}
	@Override // 전체조회 count
	public int getListCount(int member_no) {
		return sqlSession.selectOne("member_PointDto.getListCount", member_no);
	}
	@Override // 검색조회 count
	public int getStatusCount(int member_no, String member_point_status) {

		Member_PointDto memberPointDto = Member_PointDto.builder()
																							.member_no(member_no)
																							.member_point_status(member_point_status)
																							.build();
		return sqlSession.selectOne("member_PointDto.getStatusCount", memberPointDto);
	}

	@Override
	public int getTotalPoint(int member_no) {
		return sqlSession.selectOne("member_PointDto.getTotalPoint", member_no);
	}
	
	@Override // 포인트 적립추가
	public void insertPoint(Member_PointDto membePointDto) {	
		sqlSession.insert("member_PointDto.insertPoint",membePointDto);
	}
	@Override // 포인트 사용추가
	public void usedPoint(Member_PointDto memberPointDto) {
		sqlSession.insert("member_PointDto.usedPoint", memberPointDto);
	}
	

}
