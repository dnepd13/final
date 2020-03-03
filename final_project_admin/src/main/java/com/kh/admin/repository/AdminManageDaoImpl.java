package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.vo.PagingVO;
@Repository
public class AdminManageDaoImpl implements AdminManageDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BoardDao boardDao;
	
	
	
	//이거 안씀
	@Override
	public List<AdminDto> getList() {
		
		
		List<AdminDto> list = sqlSession.selectList("admin.getList");
		return list;
	}
	//페이징용 리스트 불러오기
	@Override
	public List<AdminDto> selectBoard(PagingVO vo) {
		
		List<AdminDto> list = sqlSession.selectList("admin.selectBoard", vo);
		return list;
	}

	@Override
	public int countBoard() {
		return sqlSession.selectOne("admin.countBoard");
		
	}

	@Override
	public void adminDelete(AdminDto adminDto) {
		sqlSession.delete("admin.delete", adminDto);
		
	}
	@Override
	public AdminDto adminMy(String id) {
		return sqlSession.selectOne("admin.amindMy", id);
	}
	@Override
	public AdminDto adminCheckPw(int admin_no) {
		return sqlSession.selectOne("admin.adminCheckPw", admin_no);
	}
	@Override
	public void adminChangePw(AdminDto adminDto) {
		sqlSession.update("admin.adminChangePw", adminDto);
	}
	
	

}
