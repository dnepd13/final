package com.kh.ordering.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.CustomOrderFilesDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.SellerCategoryDto;
import com.kh.ordering.entity.SellerCustomAlarmDto;
import com.kh.ordering.repository.CategoryDao;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.vo.FilesVO;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberCustomServiceImpl implements MemberCustomService{
	@Autowired
	private MemberCustomDao memberCustomDao;
	@Autowired
	private SellerCustomDao sellerCustomDao;
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private FilesDao filesDao;

	@Transactional
	@Override // 메인에서의 카테고리 요청서
	public CustomOrderDto customCate(int category_no, HttpSession session,
																	CustomOrderDto customOrderDto,
																	FilesVO files) throws IllegalStateException, IOException {

		// category 번호로 seller_no List가져오기
			List<SellerCategoryDto> getSellerNo = categoryDao.getSellerNo(category_no);

		// 요청서 저장
			String member_id = (String)session.getAttribute("member_id");
			int member_no = memberCustomDao.getNo(member_id);
			
			// 요청서를 주문제작 테이블에 저장한 뒤
			memberCustomDao.customOrderInsert(customOrderDto);	

			// 요청서 주문제작 테이블 시퀀스 가져오기
			int custom_order_no = memberCustomDao.customSeq();
			
			// 요청서 관리 테이블에 회원번호, 주문제작 번호 등록
			MemberCustomOrderDto memberCustomDto 
													= MemberCustomOrderDto.builder()
																									.custom_order_no(custom_order_no) // 주문제작 번호
																									.member_no(member_no) // 회원번호
																									.build();
			memberCustomDao.memberCustom(memberCustomDto);
			
			// 요청서 관리테이블 현재 시퀀스번호
			int member_custom_order_no = memberCustomDao.customOrderSeq();
			
			// 판매자 요청서 도착 알람 생성
			// - seller_no리스트 만큼 판매자 알람 테이블 데이터 입력
			List<SellerCustomAlarmDto> sellerAlarm = new ArrayList<>();
			
			for(SellerCategoryDto sellerList : getSellerNo) {
				
				sellerAlarm.add(SellerCustomAlarmDto.builder()
																					.seller_no(sellerList.getSeller_no())
																					.member_custom_order_no(member_custom_order_no)
																					.build());
			}
			for(int i=0; i<sellerAlarm.size();i++) {
				SellerCustomAlarmDto sellerCustomAlarmDto = sellerAlarm.get(i);
				sellerCustomDao.customAlarmInsert(sellerCustomAlarmDto);
			}
			
			// 파일이 있다면 파일 테이블에 파일 등록하고
			// 주문제작-파일 중개테이블에 파일 번호, 저장테이블 시퀀스 등록
				File dir  = new File("D:/upload/kh2d");
				dir.mkdirs();
				
				// MultipartFile을 List형태로 변환하여 파일 데이터 셋팅.
				List<FilesDto> filesList = new ArrayList<>();
				
				int files_no;
				for(MultipartFile multiFile : files.getFiles()) {
					// 파일의 다음 시퀀스 번호 미리 가져오기
					files_no =  filesDao.getSeq();
					
					// savename+파일 형식 저장
					String fileType=multiFile.getContentType().substring(6, multiFile.getContentType().length());

					filesList.add(FilesDto.builder()
															.files_no(files_no)
															.files_size(multiFile.getSize())
															.files_savename(Integer.toString(files_no)+"."+fileType)
															.files_uploadname(multiFile.getOriginalFilename())
															.build());
				}
				// 위의 filesList에 셋팅된 데이터를 filesList 길이만큼 반복하여 저장
				for(int i=0 ; i<filesList.size();i++) {
					MultipartFile multiFile = files.getFiles().get(i); // 실제 저장
					FilesDto filesDto = filesList.get(i); // DB 저장
					
					if(filesDto.getFiles_size()!=0) {
						File target = new File(dir, filesDto.getFiles_savename());
						multiFile.transferTo(target);
						filesDao.filesInsert(filesDto);
						
						// 주문제작-파일 중개테이블
						files_no = filesList.get(i).getFiles_no(); // 1번 for문의 filesList 길이만큼 files_no를 꺼내서 변수에 저장
						
						CustomOrderFilesDto customOrderFilesDto = CustomOrderFilesDto.builder()
																																					.files_no(files_no)
																																					.custom_order_no(custom_order_no)
																																					.build();
						memberCustomDao.customFilesInsert(customOrderFilesDto);
				}
			}
			
			return null;
	}
	
	@Transactional
	@Override // 상품 상세페이지에서의 1:1 요청서
	public CustomOrderDto MemberCustom(HttpSession session, int seller_no,
																				FilesVO files,
																				CustomOrderDto customOrderDto,
																				SellerCustomAlarmDto sellerCustomAlarmDto)
																				throws IllegalStateException, IOException {
		
		// 회원번호를 구해오고
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberCustomDao.getNo(member_id);
		
		// 요청서를 저장 테이블에 저장한 뒤
		memberCustomDao.customOrderInsert(customOrderDto);	
		
		// 요청서 저장 테이블 시퀀스 가져오기
		int custom_order_no = memberCustomDao.customSeq();
		
		// 요청서 관리 테이블에 회원번호, 요청서 번호 등록
		MemberCustomOrderDto memberCustomDto = MemberCustomOrderDto.builder()
																																			.custom_order_no(custom_order_no) // 요청서 번호
																																			.member_no(member_no) // 회원번호
																																			.build();
		memberCustomDao.memberCustom(memberCustomDto);
		
		// 파일이 있다면 파일 테이블에 파일 등록하고
		// 주문제작-파일 중개테이블에 파일 번호, 저장테이블 시퀀스 등록
			File dir  = new File("D:/upload/kh2d");
			dir.mkdirs();
			
			// MultipartFile을 List형태로 변환하여 파일 데이터 셋팅.
			List<FilesDto> filesList = new ArrayList<>();
			
			int files_no;
			for(MultipartFile multiFile : files.getFiles()) {
				// 파일의 다음 시퀀스 번호 미리 가져오기
				files_no =  filesDao.getSeq();
				
				// savename+파일 형식 저장
				String fileType=multiFile.getContentType().substring(6, multiFile.getContentType().length());

				filesList.add(FilesDto.builder()
														.files_no(files_no)
														.files_size(multiFile.getSize())
														.files_savename(Integer.toString(files_no)+"."+fileType)
														.files_uploadname(multiFile.getOriginalFilename())
														.build());
			}
			// 위의 filesList에 셋팅된 데이터를 filesList 길이만큼 반복하여 저장
			for(int i=0 ; i<filesList.size();i++) {
				MultipartFile multiFile = files.getFiles().get(i); // 실제 저장
				FilesDto filesDto = filesList.get(i); // DB 저장
				
				if(filesDto.getFiles_size()!=0) {
					File target = new File(dir, filesDto.getFiles_savename());
					multiFile.transferTo(target);
					filesDao.filesInsert(filesDto);
					
					// 주문제작-파일 중개테이블
					files_no = filesList.get(i).getFiles_no(); // 1번 for문의 filesList 길이만큼 files_no를 꺼내서 변수에 저장
					
					CustomOrderFilesDto customOrderFilesDto = CustomOrderFilesDto.builder()
																																				.files_no(files_no)
																																				.custom_order_no(custom_order_no)
																																				.build();
					memberCustomDao.customFilesInsert(customOrderFilesDto);
			}
		}
				
		// 판매자에게 요청서 도착 알람 생성
		//	- 판매자 ID 통해서 판매자 회원번호 가져오기.
		// - 나중에 사용자 클릭하면 파라미터 값으로 가져오기.
//		String seller_id = "11"; // 세션 임의설정
//		session.setAttribute("seller_id", seller_id);
		
//		seller_no = sellerCustomDao.getNo(seller_id);
		
		// 요청서 관리테이블 현재 시퀀스번호
		int member_custom_order_no = memberCustomDao.customOrderSeq();
		
		// 판매자 요청서 도착 알람 생성
		sellerCustomAlarmDto = SellerCustomAlarmDto.builder()
																					.seller_no(seller_no)
																					.member_custom_order_no(member_custom_order_no)
																					.build();
		sellerCustomDao.customAlarmInsert(sellerCustomAlarmDto);
		return null;
	}

// 요청서 파일 no 가져오기
	@Override
	public List<FilesVO> filesList(int member_custom_order_no){
	
		List<FilesVO> filesVO = memberCustomDao.getFilesNo(member_custom_order_no);
		
		return filesVO;
	}
	
//	보낸 요청서 목록 페이징
	@Override
	public PagingVO customReqPaging(String pageNo, int member_no) {
		// 주소로 받은 pageNo를 int 형태로 변환
			int pno;
			try {
				pno = Integer.parseInt(pageNo);
				if(pno<=0) throw new Exception();
			}
			catch(Exception e){
				pno = 1;
			}
			int pageSize= 4;
			int finish= pno*pageSize;
			int start= finish-(pageSize-1);
				
				// 하단 네비게이터
			int totalCount = memberCustomDao.customReqCount(member_no);
			int navSize= 10;
			int pageCount= (totalCount+pageSize-1)/pageSize;
				
			int startBlock= (pno-1)/navSize * navSize +1 ;
			int finishBlock= startBlock+(navSize-1);
				
			if(finishBlock>pageCount) {
				finishBlock=pageCount;
			}
				
			PagingVO pagingVO = PagingVO.builder()
																	.pno(pno)
																	.navsize(navSize)
																	.count(pageCount)
																	.pagecount(pageCount)
																	.pagesize(pageSize)
																	.startBlock(startBlock)
																	.finishBlock(finishBlock)
																	.start(start)
																	.finish(finish)
																	.member_no(member_no)
																	.build();
				
			return pagingVO;
	}

//	받은 견적서 목록 페이징
	@Override
	public PagingVO customRespPaging(String pageNo, int member_no) {
		// 주소로 받은 pageNo를 int 형태로 변환
			int pno;
			try {
				pno = Integer.parseInt(pageNo);
				if(pno<=0) throw new Exception();
			}
			catch(Exception e){
				pno = 1;
			}
				
			int pageSize= 4;
			int finish= pno*pageSize;
			int start= finish-(pageSize-1);
				
			// 하단 네비게이터
			int totalCount = memberCustomDao.customRespCount(member_no);
			int navSize= 10;
			int pageCount= (totalCount+pageSize-1)/pageSize;
				
			int startBlock= (pno-1)/navSize * navSize +1 ;
			int finishBlock= startBlock+(navSize-1);
				
			if(finishBlock>pageCount) {
				finishBlock=pageCount;
			}
			
			PagingVO pagingVO = PagingVO.builder()
																	.pno(pno)
																	.navsize(navSize)
																	.count(pageCount)
																	.pagecount(pageCount)
																	.pagesize(pageSize)
																	.startBlock(startBlock)
																	.finishBlock(finishBlock)
																	.start(start)
																	.finish(finish)
																	.member_no(member_no)
																	.build();
				
			return pagingVO;
	}
}
