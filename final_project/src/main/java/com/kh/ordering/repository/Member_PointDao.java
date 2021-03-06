package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.Member_PointDto;
import com.kh.ordering.vo.PagingVO;

public interface Member_PointDao {
	
	//가입된회원의 시퀀스를 불러온다
	int MemberGetSeq(); 
	
	// 포인트 저장 테이블
	void pointregist(Member_PointDto member_PointDto); 
	
	
	// 포인트 상세 정보보기 테이블
	List<Member_PointDto> getListPoint(PagingVO pagingVO);
	int getListCount(int member_no); // 전체조회 count
	int getStatusCount(int member_no, String member_point_status); // 검색 조회 count
	
	// 현재 총 포인트
	int getTotalPoint(int member_no);
	
	// 포인트 적립 추가
	void insertPoint(Member_PointDto membePointDto);
	// 포인트 사용 추가
	void usedPoint(Member_PointDto memberPointDto);
}
