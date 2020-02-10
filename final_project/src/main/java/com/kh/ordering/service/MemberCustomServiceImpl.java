package com.kh.ordering.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.CustomOrderFilesDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.vo.FilesVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberCustomServiceImpl implements MemberCustomService{
	@Autowired
	private MemberCustomDao memberCustomDao;
	@Autowired
	private SellerCustomDao sellerCustomDao;
	
	@Override
	public CustomOrderDto MemberCustom(HttpSession session, int seller_no,
																				FilesVO files,
																				CustomOrderDto customOrderDto,
																				SellerCustomAlarmDto sellerCustomAlarmDto)
																				throws IllegalStateException, IOException {
		
		// 회원번호를 구해오고
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		// 요청서를 저장 테이블에 저장한 뒤
		memberCustomDao.CustomOrderInsert(customOrderDto);	
		
		// 요청서 저장 테이블 시퀀스 가져오기
		int custom_order_no = memberCustomDao.CustomSeq();
		
		// 요청서 관리 테이블에 회원번호, 요청서 번호 등록
		MemberCustomOrderDto memberCustomDto = MemberCustomOrderDto.builder()
																																			.custom_order_no(custom_order_no) // 요청서 번호
																																			.member_no(member_no) // 회원번호
																																			.build();
		memberCustomDao.MemberCustom(memberCustomDto);
		
		// 파일이 있다면 파일 테이블에 파일 등록하고
		// 주문제작-파일 중개테이블에 파일 번호, 저장테이블 시퀀스 등록
		if(files!=null) {
			File dir  = new File("D:/upload");
			dir.mkdirs();
			
			// MultipartFile을 List형태로 변환하여 파일 데이터 셋팅.
			List<FilesDto> filesList = new ArrayList<>();
			
			int files_no;
			for(MultipartFile multiFile : files.getFiles()) {
				// 파일의 다음 시퀀스 번호 미리 가져오기
				files_no =  memberCustomDao.FileSeq();
				filesList.add(FilesDto.builder()
														.files_no(files_no)
														.files_size(multiFile.getSize())
														.files_savename(Integer.toString(files_no))
														.files_uploadname(multiFile.getOriginalFilename())
														.build());
			}			
			// 위의 filesList에 셋팅된 데이터를 filesList 길이만큼 반복하여 저장
			for(int i=0 ; i<filesList.size();i++) {
				MultipartFile multiFile = files.getFiles().get(i); // 실제 저장
				FilesDto filesDto = filesList.get(i); // DB 저장
				
				File target = new File(dir, filesDto.getFiles_savename());
				multiFile.transferTo(target);
				memberCustomDao.FilesInsert(filesDto);
				
				// 주문제작-파일 중개테이블
				files_no = filesList.get(i).getFiles_no(); // 1번 for문의 filesList 길이만큼 files_no를 꺼내서 변수에 저장
				
				CustomOrderFilesDto customOrderFilesDto = CustomOrderFilesDto.builder()
																																			.files_no(files_no)
																																			.custom_order_no(custom_order_no)
																																			.build();
				memberCustomDao.CustomFilesInsert(customOrderFilesDto);
			}
		}
				
		// 판매자에게 요청서 도착 알람 생성
		//	- 판매자 ID 통해서 판매자 회원번호 가져오기.
		// - 나중에 사용자 클릭하면 파라미터 값으로 가져오기.
//		String seller_id = "11"; // 세션 임의설정
//		session.setAttribute("seller_id", seller_id);
		
//		seller_no = sellerCustomDao.getNo(seller_id);
		
		// 요청서 관리테이블 현재 시퀀스번호
		int member_custom_order_no = memberCustomDao.CustomOrderSeq();
		sellerCustomAlarmDto = SellerCustomAlarmDto.builder()
																					.seller_no(seller_no)
																					.member_custom_order_no(member_custom_order_no)
																					.build();
		sellerCustomDao.CustomAlarmInsert(sellerCustomAlarmDto);
		return null;
	}
}
