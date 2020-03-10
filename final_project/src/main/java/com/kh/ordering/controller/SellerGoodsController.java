package com.kh.ordering.controller;

import java.util.ArrayList;
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
import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.entity.SellerCategoryDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.CategoryDao;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.SellerCategoryDao;
import com.kh.ordering.repository.SellerDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/seller")
public class SellerGoodsController {
	@Autowired
	private GoodsDao goodsDao;
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
	//---------------------------카테고리 관리창----------------------------------
//	@GetMapping("/serller_category")
//	public String category(
//			Model model,
//			@RequestParam(value="pno1", required = false) String pno1
//			) {
//		SellerCategoryPagingVO vo = SellerCategoryService.categoryPagination(pno1);
//		model.addAttribute("paging",vo);
//		
//		List<CategoryDto> list= sellerCategoryDao.categoryGetList(vo);
//		model.addAttribute("list", list);
//		return "/seller/seller_category";
//	
//	}

	//---------------------------카테고리 등록----------------------------------
	@GetMapping("/category_insert")
	//@ResponseBody
	public String seller_category_insert( Model model) {
		model.addAttribute("category_largeList", categoryDao.getList("category_large", "-"));
	//	log.info("msg");
		log.info("여기");
		return "/seller/category_insert";
	}
	
	@PostMapping("/category_insert")
	public ModelAndView seller_category_insert(Model model ,@ModelAttribute CategoryDto categoryDto,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String seller_id=(String)session.getAttribute("seller_id");//세션에서 아이디를 가져온다
	//System.out.println(categoryDto.getCategory_small());
		//small name search category no
		int category_no=sellerCategoryDao.category_no(categoryDto);//카테고리 넘버는 카테고리 디티오에 있다
		int seller_no=sellerCategoryDao.getNo(seller_id);//셀러 넘버는 sellercustromedao.get
	    SellerCategoryDto sellerCategoryDto=SellerCategoryDto.builder()
	    													 .seller_no(seller_no)
	    													  .category_no(category_no)
	    													  .build();            		
	    		sellerCategoryDao.seller_category_insert(sellerCategoryDto);
	  
		//        	String seller_id=(String)session.getAttribute("seller_id");
		//			log.info("seller_id={}",seller_id);
		List<Integer> list = sellerCategoryDao.seller_category_list(seller_no);
		List<CategoryDto> category_list =sellerCategoryDao.seller_category_name_list(list);
		
		log.info("여기2");
		log.info("1={}",sellerCategoryDto);
		log.info("2={}",sellerDto);
		//	model.addAttribute("category_largeList", categoryDao.getList("category_large", "-"));
		   
	      
	
			log.info("categoryDto={}",sellerCategoryDto);
	//			return "redirect:/seller/category_info?seller_no=" + seller_no;
			mv.addObject("seller_id", seller_id);
			mv.addObject("list", category_list);
			mv.setViewName("redirect:/seller/category_info");
			return mv;
		}
@PostMapping("/category_info")
public ModelAndView seller_category_info(HttpSession session) {
	ModelAndView mv = new ModelAndView();
	String seller_id=(String)session.getAttribute("seller_id");
	int seller_no=sellerCategoryDao.getNo(seller_id);
	List<Integer> list = sellerCategoryDao.seller_category_list(seller_no);
	List<CategoryDto> category_list =sellerCategoryDao.seller_category_name_list(list);
	mv.addObject("seller_id", seller_id);
	mv.addObject("category_list",category_list);
	mv.setViewName("/seller/category_info");
	return mv;
}
///---카테고리 수정---------------------------------------------------//
@PostMapping("/category_update")
@ResponseBody
public String seller_category_update(
		@RequestParam int category_no,
		@RequestParam String seller_no) {
	
	log.info("1={}", category_no);
	log.info("1={}", seller_no);
	
	SellerCategoryDto sellerCategoryDto = SellerCategoryDto.builder()
																	.category_no(category_no)
																//	.seller_no(seller_no)
																	.build();
	
	sellerCategoryDao.seller_update_category(sellerCategoryDto);
	return "/seller/category_info";
}
//---------------------------카테고리 삭제----------------------------------
	@PostMapping("/category_delete")
	@ResponseBody
	public String seller_category_delete(
			@RequestParam int category_no,
			@RequestParam int seller_no
			) {
		sellerCategoryDao.seller_delete_category(sellerCategoryDto);
		
		return "redirect:/seller/category";
	}


}