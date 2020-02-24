package com.kh.ordering.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ordering.entity.FilesDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class FilesDaoImpl implements FilesDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override // 파일 번호로 파일정보 가져오기
	public FilesDto getFiles(int files_no) {
		return sqlSession.selectOne("files.getFiles", files_no);
	}
	
	@Override
	public int insertGoodsFiles(MultipartFile multipartFile, int goods_no) {
		// 단일파일
		// 중계테이블(files_goods) : files_no, goods_no
		// 파일테이블(files) : files_no, size, savename, uploadname 
		int files_no = sqlSession.selectOne("files.getSeq");
		FilesDto filesDto = FilesDto.builder()
					.files_no(files_no)
					.files_size(multipartFile.getSize())
					.files_savename("goodsMain"+files_no)
					.files_uploadname(multipartFile.getOriginalFilename())
				.build();
		sqlSession.insert("files.insert", filesDto);
		Map<String, Integer> map = new HashMap<>();
		map.put("files_no", files_no);
		map.put("goods_no", goods_no);
		sqlSession.insert("files.insertFilesGoods", map);
		
		return files_no;
	}
	
	@Override
	public List<Integer> insertGoodsFiles(MultipartFile[] multipartFileList, int goods_no) {
		List<FilesDto> filesDtoList = new ArrayList<>();
		List<Integer> list = new ArrayList<>();
		for(MultipartFile file : multipartFileList) {
			int files_no = sqlSession.selectOne("files.getSeq");
			FilesDto filesDto = FilesDto.builder()
						.files_no(files_no)
						.files_size(file.getSize())
						.files_savename("goodsContent"+files_no)
						.files_uploadname(file.getOriginalFilename())
					.build();
			filesDtoList.add(filesDto);
			list.add(files_no);
		}
		sqlSession.insert("files.insertAll", filesDtoList);
		
		for(FilesDto filesDto : filesDtoList) {
			Map<String, Integer> map = new HashMap<>();
			log.info("22222{}", filesDto.getFiles_no());
			map.put("files_no", filesDto.getFiles_no());
			map.put("goods_no", goods_no);
			sqlSession.insert("files.insertFilesGoods", map);
		}
		return list;
	}
}
