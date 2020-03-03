package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.vo.PagingVO;

public interface AdminManageDao {
	List<AdminDto> getList();
	public int countBoard();
	public List<AdminDto> selectBoard(PagingVO vo);
	public void adminDelete(AdminDto adminDto);
	public AdminDto adminMy(String id);
	
	//관리자 비밀번호 확인
	public AdminDto adminCheckPw(int admin_no);
	
	//관리자 비밀번호변경
	public void adminChangePw(AdminDto adminDto);
	
}
