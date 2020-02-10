package com.kh.ordering.repository;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.CustomOrderFilesDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.vo.CustomOrderVO;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.entity.MemberDto;

@Repository
public class MemberCustomDaoImpl implements MemberCustomDao{

	@Autowired
	private SqlSession sqlSession;

	//	회원id로 회원번호 구하기
	@Override
	public int getNo(String member_id) {
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
	@Override // 요청서 관리테이블 .currval 시퀀스번호
	public int CustomOrderSeq() {
		return sqlSession.selectOne("member.customOrderSeq");
	}

	@Override //요청서 .currval 시퀀스
	public int CustomSeq() {		
		return sqlSession.selectOne("member.customSeq");
	}
	
	@Override // 파일 .nextval 시퀀스번호
	public int FileSeq() {
		return sqlSession.selectOne("files.getSeq");
	}	
	@Override // 파일테이블 저장
	public void FilesInsert(FilesDto filesDto) {
		sqlSession.insert("files.insert", filesDto);
	}
	@Override // 주문제작-파일 테이블 입력
	public void CustomFilesInsert(CustomOrderFilesDto customOrderFilesDto) {
		sqlSession.insert("files.customInsert", customOrderFilesDto);
	}

	@Override // 판매자가 보낸 견적서 전체보기
	public List<CustomOrderDto> getListCustom(int member_no) {
		
		return sqlSession.selectList("member.getListCustom", member_no);
	}	
	@Override // 판매자 견적서 상세보기. 주문제작번호 단일조회
	public CustomOrderVO customOrderVO(int custom_order_no) {
		return sqlSession.selectOne("member.getListInfo", custom_order_no);
	}

	@Override // 내가 보낸 요청서 보기
	public List<CustomOrderDto> getListReq(int member_no) {
		
		return sqlSession.selectList("member.getListReq", member_no);
	}	
	
// 견적서 도착 알람 테이블 입력
	@Override
	public void CustomAlarmInsert(MemberCustomAlarmDto memberCustomAlarmDto) {
		sqlSession.insert("member.insertAlarm", memberCustomAlarmDto);
	}

}
