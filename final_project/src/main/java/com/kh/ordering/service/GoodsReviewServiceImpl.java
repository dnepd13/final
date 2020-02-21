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

import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.GoodsReviewDto;
import com.kh.ordering.entity.GoodsReviewFilesDto;
import com.kh.ordering.entity.Member_PointDto;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.GoodsReviewDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.Member_PointDao;
import com.kh.ordering.vo.FilesVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class GoodsReviewServiceImpl implements GoodsReviewService {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private GoodsReviewDao goodsReviewDao;
	@Autowired
	private Member_PointDao memberPointDao;
	@Autowired
	private FilesDao filesDao;
	
	@Override
	public GoodsReviewDto insertReview(HttpSession session, FilesVO files,
																		@RequestParam int cart_info_no,
																		@ModelAttribute GoodsReviewDto goodsReviewDto)
																		throws IllegalStateException, IOException {
		// writer 
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);
		
		if(member_no==goodsReviewDto.getMember_no()) {
			// 별점 구현하여 가져오기
			// 히든으로 넘어오지 않는 정보: goods_no, writer, ordering_no
			// 서비스에 들어가야 할 내용: 리뷰 등록 및 파일 insert

			// ordering_no 구하기
			int ordering_no = goodsReviewDao.getOrderingNo(cart_info_no);	
			// goods_no 구하기
			int goods_no = goodsReviewDao.getGoodsNo(cart_info_no);

			goodsReviewDto.setOrdering_no(ordering_no);
			goodsReviewDto.setGoods_no(goods_no);
			goodsReviewDto.setMember_no(member_no);
			goodsReviewDto.setGoods_review_writer(member_id);
			
			goodsReviewDao.insertReview(goodsReviewDto);
			
			// 현재 Review No 번호 가져오기
			int goods_review_no = goodsReviewDao.getNoCurr();		
			
			// 파일이 있다면 파일 등록
			File dir = new File("D:/upload/kh2d");
			dir.mkdirs();
			
			int files_no;
			
			List<FilesDto> filesList = new ArrayList<>();
			for(MultipartFile multiFile : files.getFiles()) {
				files_no = filesDao.getSeq();
				
				String fileType= multiFile.getContentType().substring(6, multiFile.getContentType().length());
				
				filesList.add(FilesDto.builder()
														.files_no(files_no)
														.files_size(multiFile.getSize())
														.files_savename(Integer.toString(files_no)+"."+fileType)
														.files_uploadname(multiFile.getOriginalFilename())
														.build());
			}
			for(int i =0 ; i<filesList.size(); i++) {
				MultipartFile multiFile = files.getFiles().get(i);
				FilesDto filesDto = filesList.get(i);
				
				if(filesDto.getFiles_size()!=0) {
					File target = new File(dir, filesDto.getFiles_savename());
					multiFile.transferTo(target);
					filesDao.filesInsert(filesDto);
					
					// 리뷰-파일 중개테이블
					files_no = filesList.get(i).getFiles_no();
					
					GoodsReviewFilesDto goodsReviewFilesDto
																= GoodsReviewFilesDto.builder()
																											.files_no(files_no)
																											.member_no(member_no)
																											.goods_review_no(goods_review_no)
																											.build();
					goodsReviewDao.reviewFilesInsert(goodsReviewFilesDto);
				}
			}
			
			// 리뷰 입력 시 포인트 추가
			Member_PointDto memberPointDt0
											= Member_PointDto.builder()
																				.member_point_change(50)
																				.member_point_content("리뷰적립")
																				.member_no(member_no)
																				.build();
									
			memberPointDao.insertPoint(memberPointDt0);
		}
		
		return null;
	}

	// 리뷰 파일 no 가져오기(출력)
	@Override
	public List<FilesVO> filesList(int goods_review_no){
	
		List<FilesVO> filesVO = goodsReviewDao.getFilesNo(goods_review_no);
		
		return filesVO;
	}	

}
