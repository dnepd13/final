package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.MemberDto;
import com.kh.admin.vo.PagingVO;

public interface MemberDao {
	public int memberCount();
	public List<MemberDto> memberGetList(PagingVO vo);
}
