package com.kh.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.admin.repository.GoodsDao;
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
