package com.kh.ordering.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.FilesDto;

@Repository
public class FilesDaoImpl implements FilesDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override // 파일 번호로 파일정보 가져오기
	public FilesDto getFiles(int files_no) {
		return sqlSession.selectOne("files.getFiles", files_no);
	}
	
}
