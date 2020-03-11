package com.kh.ordering.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.GoodsReviewDao;
import com.kh.ordering.service.GoodsService;
import com.kh.ordering.vo.GoodsFileVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private GoodsReviewDao goodsReviewDao;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@GetMapping("/")
	@RegueiredAuth
	public String home(Model model) {
		List<GoodsFileVO> listNew = goodsService.getListNew();
		List<Integer> starListNew = new ArrayList<>();
		for (GoodsFileVO goodsFileVO : listNew) {
			starListNew.add(goodsReviewDao.getStarAvg(goodsFileVO.getGoodsDto().getGoods_no()));
		}
		model.addAttribute("listNew", listNew);
		model.addAttribute("starListNew", starListNew);
		
		List<GoodsFileVO> listBest = goodsService.getListBest();
		List<Integer> starListBest = new ArrayList<>();
		for (GoodsFileVO goodsFileVO : listBest) {
			starListBest.add(goodsReviewDao.getStarAvg(goodsFileVO.getGoodsDto().getGoods_no()));
		}
		model.addAttribute("listBest", listBest);
		model.addAttribute("starListBest", starListBest);
		
		// 전체 상품
		List<GoodsDto> list = goodsService.getList();
		List<GoodsFileVO> VOlist = new ArrayList<>();
		List<Integer> starList = new ArrayList<>();
		for (GoodsDto goodsDto : list) {
			GoodsFileVO goodsFileVO = GoodsFileVO.builder()
					.goodsDto(goodsDto)
					.goods_main_image(goodsDao.getGoodsMainImage(goodsDto.getGoods_no()))
					.build();
			VOlist.add(goodsFileVO);
			
			// 리뷰
			starList.add(goodsReviewDao.getStarAvg(goodsDto.getGoods_no()));
		}
		model.addAttribute("starList", starList);
		model.addAttribute("list", VOlist);
	//			model.addAttribute("VOList", VOlist);
		
		return "/home";
	}
}
