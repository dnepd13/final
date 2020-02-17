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
import com.kh.ordering.vo.PagingVO;
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
	public void customOrderInsert(CustomOrderDto customOrderDto) {
		sqlSession.insert("member.customReq", customOrderDto);
	}	
	@Override // 요청서 관리 저장
	public void memberCustom(MemberCustomOrderDto memberCustomDto) {	
		sqlSession.insert("member.customInsert", memberCustomDto);
	}
	@Override // 요청서 관리테이블 .currval 시퀀스번호
	public int customOrderSeq() {
		return sqlSession.selectOne("member.customOrderSeq");
	}

	@Override //요청서 .currval 시퀀스
	public int customSeq() {		
		return sqlSession.selectOne("member.customSeq");
	}
	
	@Override // 견적서 도착 알람 테이블 입력
	public void customAlarmInsert(MemberCustomAlarmDto memberCustomAlarmDto) {
		sqlSession.insert("member.insertAlarm", memberCustomAlarmDto);
	}
	
	@Override // 파일 .nextval 시퀀스번호
	public int fileSeq() {
		return sqlSession.selectOne("files.getSeq");
	}	
	@Override // 파일테이블 저장
	public void filesInsert(FilesDto filesDto) {
		sqlSession.insert("files.insert", filesDto);
	}
	@Override // 주문제작-파일 테이블 입력
	public void customFilesInsert(CustomOrderFilesDto customOrderFilesDto) {
		sqlSession.insert("files.customInsert", customOrderFilesDto);
	}

	@Override // 판매자가 보낸 견적서 전체보기
	public List<CustomOrderVO> getListResp(PagingVO paging) {
		
		return sqlSession.selectList("member.getListResp", paging);
	}	
	@Override // 판매자 견적서 상세보기. 주문제작번호 단일조회
	public CustomOrderVO customOrderVO1(int seller_custom_order_no) {
		return sqlSession.selectOne("member.getListInfoResp", seller_custom_order_no);
	}
	@Override // 견적서 상세페이지 확인하면 구매자 알람테이블 업데이트
	public void updateAlarm(int member_no, int seller_custom_order_no) {
		MemberCustomAlarmDto updateAlarm = MemberCustomAlarmDto.builder()
																																.member_no(member_no)
																																.seller_custom_order_no(seller_custom_order_no)
																																.build();
		sqlSession.update("member.updateAlarm", updateAlarm);
	}
	@Override // 구매자 알람테이블 check N count
	public int customAlarm(int member_no) {
		return sqlSession.selectOne("member.customCheck", member_no);
	}

	@Override // 구매자가 받은 견적서 count
	public int customRespCount(int member_no) {
		return sqlSession.selectOne("member.customRespTest", member_no);
	}
	
	// 내가 보낸 요청서 보기
	@Override // 목록
	public List<CustomOrderVO> getListReq(PagingVO paging) {	
		return sqlSession.selectList("member.getListReq", paging);
	}
	@Override // 상세보기
	public CustomOrderVO customOrderVO2(int member_custom_order_no) {
		return sqlSession.selectOne("member.getListInfoReq", member_custom_order_no);
	}
	@Override // 요청서의 파일번호
	public List<FilesVO> getFilesNo(int member_custom_order_no) {
		return sqlSession.selectList("member.getReqFilesNo", member_custom_order_no);
	}
	@Override // 보낸 요청서 count (페이징 용도)
	public int customReqCount(int member_no) {
		return sqlSession.selectOne("member.customReqCount", member_no);
	}
	
}
