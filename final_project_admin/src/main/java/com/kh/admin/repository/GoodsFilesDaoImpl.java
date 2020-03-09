package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.FilesDto;

@Repository
public class GoodsFilesDaoImpl implements GoodsFilesDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<FilesDto> getGoodsFiles(int goods_no) {
		return sqlSession.selectList("admin.getGoodsFiles", goods_no);
	}
	@Override
	public FilesDto getFile(int files_no) {
		return sqlSession.selectOne("admin.getFile", files_no);
	}
	
}
