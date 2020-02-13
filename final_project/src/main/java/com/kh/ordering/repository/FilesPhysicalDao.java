package com.kh.ordering.repository;

import java.io.IOException;

public interface FilesPhysicalDao {
	// 주문제작-파일 다운로드
	byte[] get(int files_no) throws IOException;
}
