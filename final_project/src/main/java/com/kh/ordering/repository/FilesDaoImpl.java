package com.kh.ordering.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.FilesDto;

@Repository
public class FilesDaoImpl implements FilesDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override // 파일 .nextval 시퀀스번호
	public int getSeq() { 
		return sqlSession.selectOne("files.getSeq");
	}
	@Override // 파일 번호로 파일정보 가져오기
	public FilesDto getFiles(int files_no) {
		return sqlSession.selectOne("files.getFiles", files_no);
	}
	
	@Override // 파일테이블 저장
	public void filesInsert(FilesDto filesDto) {
		sqlSession.insert("files.insert", filesDto);
	}
	
}
