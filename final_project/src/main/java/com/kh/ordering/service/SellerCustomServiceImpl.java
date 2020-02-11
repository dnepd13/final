package com.kh.ordering.service;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.CustomOrderFilesDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.vo.FilesVO;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class SellerCustomServiceImpl implements SellerCustomService{
	
	@Autowired
	private SellerCustomDao sellerCustomDao;
	@Autowired
	private MemberCustomDao memberCustomDao;

//	견적서 등록 service
	@Override
	public CustomOrderDto SellerCustom(HttpSession session,
																@RequestParam int member_no,
																@ModelAttribute FilesVO files,
																@ModelAttribute CustomOrderDto customOrderDto,
																@ModelAttribute SellerCustomOrderDto sellerCustomDto,
																@ModelAttribute MemberCustomAlarmDto memberCustomAlarmDto)
																throws IllegalStateException, IOException {

		String seller_id=(String)session.getAttribute("seller_id");
		int seller_no = sellerCustomDao.getNo(seller_id);

		// 견적서 저장하고
		sellerCustomDao.CustomOrderInsert(customOrderDto);
		
		// 견적서 저장 테이블 시퀀스 가져오기
		int custom_order_no = sellerCustomDao.CustomSeq();
		// 견적서 관리 테이블에 판매자번호, 견적서 번호 등록
		sellerCustomDto = SellerCustomOrderDto.builder()
																		.custom_order_no(custom_order_no)
																		.seller_no(seller_no)
																		.build();
		sellerCustomDao.SellerCustom(sellerCustomDto);

		//		- 파일이 있으면 파일테이블에 등록
		if(files!=null) {
			File dir = new File("D:/upload");
			dir.mkdirs();
			
			// MultipartFile 객체인 FileVO를 DB에 저장하기 위한 List 형태로 변환
			List<FilesDto> filesList = new ArrayList<>();
		
			int files_no;
			for(MultipartFile multiFile : files.getFiles()) {
				// 파일 시퀀스번호 미리 가져오기
				files_no= sellerCustomDao.FilesSeq();
				filesList.add(FilesDto.builder()
														.files_no(files_no)
														.files_size(multiFile.getSize())
														.files_savename(Integer.toString(files_no))
														.files_uploadname(multiFile.getOriginalFilename())
														.build());
			}
			// filesList 길이만큼 DB와 Disk에 저장
			for(int i=0; i<filesList.size(); i++) {
				MultipartFile multiFile = files.getFiles().get(i);
				FilesDto filesDto = filesList.get(i);
				
				File target = new File(dir, filesDto.getFiles_savename());
				multiFile.transferTo(target);
				
				sellerCustomDao.FilesInsert(filesDto);
				
				// 주문제작-파일 테이블
				files_no = filesList.get(i).getFiles_no();
				CustomOrderFilesDto customOrderFilesDto = CustomOrderFilesDto.builder()
																																		.files_no(files_no)
																																		.custom_order_no(custom_order_no)
																																		.build();
				sellerCustomDao.CustomFilesInsert(customOrderFilesDto);
			}
		}

		int seller_custom_order_no = sellerCustomDao.CustomOrderSeq();
		//구매자에게 견적서 도착 알람 생성
		// - 구매자 ID 통해서 구매자 회원번호 가져오기
//		String member_id = "member"; // 세션 임의설정
//		session.setAttribute("member_id", member_id);
		
//		int member_no = memberCustomDao.getNo(member_id);
		memberCustomAlarmDto = MemberCustomAlarmDto.builder()
																								.member_no(member_no)
																								.seller_custom_order_no(seller_custom_order_no)
																								.build();
		memberCustomDao.CustomAlarmInsert(memberCustomAlarmDto);
		return null;
	}

	
}
