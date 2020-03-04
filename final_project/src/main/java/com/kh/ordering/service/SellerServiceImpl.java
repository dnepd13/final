package com.kh.ordering.service;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.CustomOrderFilesDto;
import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.PortfolioDto;
import com.kh.ordering.entity.SellerCustomOrderDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.PortfolioDao;
import com.kh.ordering.repository.SellerCategoryDao;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.vo.FilesVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class SellerServiceImpl  implements SellerService{
@Autowired
private SellerDao sellerDao;
@Autowired
private FilesDao filesDao;
@Autowired
private PortfolioDao portfolioDao;
@Autowired
private SellerCategoryDao sellerCategoryDao;



	@Override
	public void regist(SellerDto sellerDto) {
		//등록을 위한 정보 생성
		// - 등록에 앞서서 회원번호를 먼저 구해온다
		
		//판매자 번호 추출
				int seller_no = sellerDao.getSequence();
				
				//판매자 회원 등록
				sellerDto.setSeller_no(seller_no);
				sellerDao.regist(sellerDto);
	}



//	@Override
//	public SellerDto login(SellerDto sellerDto) {//보낸거 id pw
//		sellerDto.getSeller_id();
//	SellerDto find = sellerDao.login(sellerDto);//로그인으로 들어간거
//		return sellerDto;
//	}
	public SellerDto login(SellerDto sellerDto) {//보낸거 id pw
		sellerDto.getSeller_id();
		//로그인으로 들어간거
		return sellerDao.login(sellerDto);
	}


    //------------포트폴리오 등록하기--------------// 
	@Override
	public PortfolioDto Portfolio_insert(HttpSession session,
			FilesVO files, SellerDto sellerDto,PortfolioDto portfolioDto)
			throws IllegalStateException, IOException {
		//세션에서 판매자 아이디를 가져와서 판매자 카테고리 다오에서 넘버를 꺼내서 온다
		 String seller_id=(String)session.getAttribute("seller_id");
		int seller_no=sellerCategoryDao.getNo(seller_id);
				log.info("seller_id[]"+seller_id);
		
		// 파일이 있다면 파일 테이블에 파일 등록하고
				File dir  = new File("D:/upload/kh2d");//파일을 넣을 폴더 경로
				dir.mkdirs();//폴더가 없으면 폴더 생성
				
//	    String path ="/usr/local/upload/kh2d";//파일을 넣을 폴더 경로
//		File dir  = new File(path);
//		//	File dir  = new File("D:/upload/kh2d");
//		if(!dir.exists()) {
//		dir.mkdirs(); //폴더가 없으면 폴더생성 
//		}
		// MultipartFile을 List형태로 변환하여 파일 데이터 셋팅.
		List<FilesDto> filesList = new ArrayList<>();
		
		
		//파일넘버를 filesdao에서 꺼내온다
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
						
						// 포트폴리오 테이블
						files_no = filesList.get(i).getFiles_no(); // 1번 for문의 filesList 길이만큼 files_no를 꺼내서 변수에 저장
						
						PortfolioDto portfolioDto1 =PortfolioDto.builder()
																.files_no(files_no)
															    .seller_no(seller_no)
								                                .build();
						portfolioDao.Portfolio_insert(portfolioDto1);
					}
				}
				return portfolioDto;
	
	}



	
				}


