package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.AdminQnaBoardDto;
import com.kh.admin.vo.PagingVO;

public interface BoardDao {
	public int adminQnaCount();
	public List<AdminQnaBoardDto> qnaBoardGetList(PagingVO vo);
	public AdminQnaBoardDto qnaBoardGetOne(AdminQnaBoardDto adminQnaBoardDto);
	public void qnaBoardInsertNew(AdminQnaBoardDto adminQnaBoardDto);
	public void qnaBoardInsertSecond(AdminQnaBoardDto adminQnaBoardDto);
	public void qnaBoardUpdate(AdminQnaBoardDto adminQnaBoardDto);
	public void qnaBoardDelete(AdminQnaBoardDto adminQnaBoardDto);
	public int qnaBoardTitleCount(String admin_qna_title);
	public int qnaBoardHeadCount(String admin_qna_head);
}
