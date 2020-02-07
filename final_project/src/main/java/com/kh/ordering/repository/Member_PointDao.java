package com.kh.ordering.repository;

import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.Member_PointDto;

public interface Member_PointDao {
	
	
	int MemberGetSeq(); //가입된회원의 시퀀스를 불러온다
	void pointregist(Member_PointDto member_PointDto); // 포인트 저장 테이블
	
	
	void registsuccess(Member_PointDto member_pointDto);
}
