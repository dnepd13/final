package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.MemberDto;
import com.kh.admin.vo.BlockMemberVO;
import com.kh.admin.vo.MemberPointVO;
import com.kh.admin.vo.PagingVO;

public interface MemberDao {
	public int memberCount();
	public List<BlockMemberVO> memberGetList(PagingVO vo);
	public void memberDelete(MemberDto memberDto);
	public MemberDto memberGetOne(MemberDto memberDto);
	public List<MemberPointVO> pointGetList();
	public int pointSumGet(MemberPointVO memberPointVO);
	public int pointCount(MemberPointVO memberPointVO);
	public List<MemberPointVO> pointGetOneMemberList(PagingVO paging);
	public void poingDelete(int member_point_no);
	public void pointRegist(MemberPointVO memberPointVO);
}
