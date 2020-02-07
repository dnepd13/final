package com.kh.ordering.repository;

import com.kh.ordering.entity.MemberDto;

public interface MemberDao {

	
	
//	MemberDto getMemberDto(int seq) throws Exception;
	int MemberSeq();
	void regist(MemberDto memberDto);


}
