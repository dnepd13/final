package com.kh.ordering.repository;

import java.util.List;

import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.Member_PointDto;

public interface Member_PointDao {
	
	//가입된회원의 시퀀스를 불러온다
	int MemberGetSeq(); 
	
	// 포인트 저장 테이블
	void pointregist(Member_PointDto member_PointDto); 
	
	
	// 포인트 상세 정보보기 테이블
	List<Member_PointDto> getListPoint(int member_no);
}
