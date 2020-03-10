package com.kh.admin.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.admin.entity.FilesDto;
import com.kh.admin.repository.AdminDao;
import com.kh.admin.repository.GoodsDao;
import com.kh.admin.repository.GoodsFilesDao;
import com.kh.admin.repository.GoodsReviewDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.vo.GoodsCategoryVO;
import com.kh.admin.vo.GoodsVO;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/goods")
@Slf4j
public class GoodsController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private GoodsReviewDao goodsReviewDao;
	
	@Autowired
	private GoodsFilesDao goodsFilesDao;
	
	@Autowired
	private AdminDao adminDao;
	//---------------------------상품 리스트 뽑기----------------------------------

		@GetMapping("/list")
		public String goods(Model model, 
				@RequestParam(value="pno1", required = false) String pno1,
				@ModelAttribute PagingVO paging
				) {
				int count;
				if(paging.getKey()==null) {
					count = goodsDao.goodsCount();
					PagingVO vo = boardService.allPaging(pno1, count);
					model.addAttribute("paging", vo);
					
					List<GoodsCategoryVO> list = goodsDao.listGoods(vo);
					model.addAttribute("list", list);
					
					return "goods/list";
				}
				else if(paging.getKey().equalsIgnoreCase("goods_name")) {
					count = goodsDao.goodsNameCount(paging.getSearch());
					PagingVO vo = boardService.allPaging(pno1, count);
					model.addAttribute("paging", vo);
					vo.setKey(paging.getKey());
					vo.setSearch(paging.getSearch());
					List<GoodsCategoryVO> list = goodsDao.listGoods(vo);
					model.addAttribute("list", list);
					return "goods/list";
				}
				else if(paging.getKey().equalsIgnoreCase("seller_id")) {
					count = goodsDao.goodsIdCount(paging.getSearch());
					PagingVO vo = boardService.allPaging(pno1, count);
					model.addAttribute("paging", vo);
					vo.setKey(paging.getKey());
					vo.setSearch(paging.getSearch());
					List<GoodsCategoryVO> list = goodsDao.listGoods(vo);
					model.addAttribute("list", list);
					return "goods/list";
				}
				else {
					
					return "goods/list";
				}
				
		}
		
		//---------------------------상품 상세보기----------------------------------
		
		@GetMapping("/getone")
		public String getone(
				@ModelAttribute GoodsVO goodsVO,
				@RequestParam String seller_id,
				Model model
				) {
				
			GoodsVO list = goodsDao.getGoodsVO(goodsVO.getGoods_no());
			log.info("list={}",list);
			model.addAttribute("list", list);
			
			//사진가져오기
			int goods_no = goodsVO.getGoods_no();
			List<FilesDto> file = goodsFilesDao.getGoodsFiles(goods_no);
			
			model.addAttribute("file", file);
			
			return "goods/getone";
		}
		
		//---------------------------상품 삭제----------------------------------
		@GetMapping("/delete")
		public String goodsdelete(
				@ModelAttribute GoodsVO goodsVO
				) {
			
			goodsDao.goodsDelete(goodsVO);
			return "redirect:/goods/list";
		}
		
		//---------------------------상품 별 리뷰목록----------------------------------
		@GetMapping("/review")
		public String review(@RequestParam int goods_no, Model model) {
				
			model.addAttribute("list", goodsReviewDao.reviewList(goods_no));
			return "goods/review";
		}
		
		//파일 이미지 다운로드
		@GetMapping("/download")
		public ResponseEntity<ByteArrayResource> goodsfile(
				@RequestParam int files_no
				){
			try {
			FilesDto filesDto = goodsFilesDao.getFile(files_no);
			
			//파일 이름 가져오기
				byte[] data = adminDao.get(files_no);
				if(data == null) {
					return ResponseEntity.notFound().build();
				}
			
				ByteArrayResource resource = new ByteArrayResource(data);
				
				return ResponseEntity.ok()
						.contentType(MediaType.APPLICATION_OCTET_STREAM)
						.contentLength(filesDto.getFiles_size())
						.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+URLEncoder.encode(filesDto.getFiles_savename(),"UTF-8")+"\"")
						.body(resource);
				
			} catch (IOException e) {
				e.printStackTrace();
				return ResponseEntity.notFound().build();
			}
			
		}
		
		
		//resultmap을 써서 부른것
		//	@GetMapping("/goods")
//		public String goods(
//				Model model
//				) {
//			List<GoodsVO> list= goodsDao.getGoodsVO();
//			model.addAttribute("list", list);
//			return "/goods";
//		}
}
