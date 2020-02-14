package com.kh.ordering.repository;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.FilesDto;

@Repository
public class FilesPhysicalDaoImpl implements FilesPhysicalDao{
	
	private File directory= new File("D:/upload/kh2d");
	
	// directory 생성하면서 실행할 준비 메소드
	@PostConstruct
	public void init() {
		directory.mkdirs(); // 폴더생성
	}
	
	@Autowired
	private FilesDao filesDao;
	
	// 파일 출력
	@Override
	public byte[] get(int files_no) throws IOException {
		// directory의 파일이름 찾아서 불러오고 반환
		FilesDto filesDto = filesDao.getFiles(files_no);
		
		File file = new File(directory, filesDto.getFiles_savename());
		byte[] data = FileUtils.readFileToByteArray(file);
		return data;
	}

}
