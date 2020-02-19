package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.MemberDto;
import com.kh.admin.vo.BlockMemberVO;
import com.kh.admin.vo.MemberPointVO;
import com.kh.admin.vo.PagingVO;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int memberCount() {
		int result = sqlSession.selectOne("admin.memberCount");
		return result;
	}

	@Override
	public List<BlockMemberVO> memberGetList(PagingVO vo) {
		List<BlockMemberVO> list = sqlSession.selectList("admin.memberGetList", vo);
		return list;
	}

	@Override
	public void memberDelete(MemberDto memberDto) {
		sqlSession.delete("admin.memberDelete", memberDto);
	}

	@Override
	public MemberDto memberGetOne(MemberDto memberDto) {
		
		MemberDto result = sqlSession.selectOne("admin.memberGetOne", memberDto);
		return result;
		
	}

	@Override
	public List<MemberPointVO> pointGetList() {
		List<MemberPointVO> list = sqlSession.selectList("admin.pointMember");
		return list;
	}

	@Override
	public int pointSumGet(MemberPointVO memberPointVO) {
		return sqlSession.selectOne("admin.pointSumMember", memberPointVO);
	}

	@Override
	public int pointCount(MemberPointVO memberPointVO) {
		return sqlSession.selectOne("admin.pointMemberCount", memberPointVO);
	}

	@Override
	public List<MemberPointVO> pointGetOneMemberList(PagingVO paging) {
		List<MemberPointVO> list = sqlSession.selectList("admin.pointMember", paging);
				return list;
	}

	@Override
	public void poingDelete(int member_point_no) {
		sqlSession.delete("admin.pointDelete", member_point_no);
	}

	@Override
	public void pointRegist(MemberPointVO memberPointVO) {
		sqlSession.insert("admin.pointRegist", memberPointVO);
	}

	@Override
	public int memberIdCount(String member_id) {
		return sqlSession.selectOne("admin.memberIdCount", member_id);
	}

	@Override
	public int memberNameCount(String member_name) {
		return sqlSession.selectOne("admin.memberNameCount", member_name);
	}

	@Override
	public int memberGradeCount(String member_grade) {
		return sqlSession.selectOne("admin.memberGradeCount", member_grade );
	}

	@Override
	public void memberPointMulti(List<MemberPointVO> list) {
		sqlSession.insert("admin.insertAll", list);
	}

}
