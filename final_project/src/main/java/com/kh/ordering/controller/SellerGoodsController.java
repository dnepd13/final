package com.kh.ordering.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ordering.entity.CategoryDto;
import com.kh.ordering.entity.SellerCategoryDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.CategoryDao;
import com.kh.ordering.repository.SellerCategoryDao;
import com.kh.ordering.repository.SellerCustomDao;
import com.kh.ordering.repository.SellerDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/seller")
public class SellerGoodsController {
	@Autowired
	private SellerCategoryDto sellerCategoryDto;
	@Autowired
	private SellerCategoryDao sellerCategoryDao;
	@Autowired
	private CategoryDto categoryDto;
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private SellerDto sellerDto;
	@Autowired
	private SellerDao sellerDao;

	//---------------------------카테고리 등록----------------------------------
	
	@GetMapping("/category_insert")
	public ModelAndView category_insert(Model model,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("category_largeList", categoryDao.getList("category_large", "-"));
		String seller_id=(String)session.getAttribute("seller_id");
		int seller_no=sellerCategoryDao.getNo(seller_id);
		List<Integer> list = sellerCategoryDao.seller_category_list(seller_no);
		List<CategoryDto> category_list=null;
		if(list.size()>0) {
			category_list =sellerCategoryDao.seller_category_name_list(list);	
		}
		mv.addObject("seller_id", seller_id);
		mv.addObject("category_list",category_list);
		mv.addObject("seller_no", seller_no);
		mv.setViewName("/seller/category_insert");
		return mv;
	}
	
	
	@PostMapping("/category_insert_proc")
	//@ResponseBody
	public String category_insert_proc(Model model ,@ModelAttribute CategoryDto categoryDto,HttpSession session) {
		String seller_id=(String)session.getAttribute("seller_id");//세션에서 아이디를 가져온다
		int category_no=sellerCategoryDao.category_no(categoryDto);//카테고리 넘버는 카테고리 디티오에 있다
		int seller_no=sellerCategoryDao.getNo(seller_id);//셀러 넘버는 sellercustromedao.get
	    SellerCategoryDto sellerCategoryDto=SellerCategoryDto.builder()
	    													 .seller_no(seller_no)
	    													  .category_no(category_no)
	    													  .build();            		
	    		sellerCategoryDao.seller_category_insert(sellerCategoryDto);
	    return "redirect:/seller/category_insert";
	}
//---------------------------카테고리 삭제----------------------------------
	@PostMapping("/category_delete")
	//@ResponseBody
	public String seller_category_delete(@ModelAttribute SellerCategoryDto sellerCategoryDto) {
		sellerCategoryDao.seller_delete_category(sellerCategoryDto);	
		
		return "redirect:/seller/category_insert";
	}
}
