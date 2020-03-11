package com.kh.ordering.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.service.GoodsService;
import com.kh.ordering.vo.GoodsFileVO;

@Controller
public class HomeController {
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@GetMapping("/")
	@RegueiredAuth
	public String home(Model model) {
		model.addAttribute("listNew", goodsService.getListNew());
		model.addAttribute("listBest", goodsService.getListBest());
		
		// 전체 상품
		List<GoodsDto> list = goodsService.getList();
		List<GoodsFileVO> VOlist = new ArrayList<>();
		for (GoodsDto goodsDto : list) {
			GoodsFileVO goodsFileVO = GoodsFileVO.builder()
					.goodsDto(goodsDto)
					.goods_main_image(goodsDao.getGoodsMainImage(goodsDto.getGoods_no()))
					.build();
			VOlist.add(goodsFileVO);
		}
		model.addAttribute("list", VOlist);
	//			model.addAttribute("VOList", VOlist);
		
		return "/home";
	}
}
