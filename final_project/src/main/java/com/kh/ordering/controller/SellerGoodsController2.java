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
import com.kh.ordering.service.SellerService;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/seller")
public class SellerGoodsController2 {
	@Autowired
	private SellerService sellerService;
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
//	@GetMapping("/category")
//	public String category(
//			Model model,
//			@RequestParam(value="pno1", required = false) String pno1
//			) {
//		try {
//		PagingVO vo = sellerService.categoryPagination(pno1);
//		model.addAttribute("paging",vo);
//		
//		List<CategoryDto> list= sellerCategoryDao.categoryGetList(vo);
//		model.addAttribute("list", list);
//		model.addAttribute("big", sellerCategoryDao.categoryBig());
//		model.addAttribute("middle", sellerCategoryDao.categoryMiddle());
//		model.addAttribute("small", sellerCategoryDao.categorySmall());
//		log.info("small={}", sellerCategoryDao.categorySmall());
//		return "/seller_category_insert";
//		} catch (Exception e) {
//			e.printStackTrace();
//			return "/seller_category_insert";
//		}
//	}

	//---------------------------카테고리 관리----------------------------------
	@GetMapping("/category_insert")
	//@ResponseBody
	public String seller_category_insert( Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
		try {
			PagingVO vo = sellerService.categoryPagination(pno1);
			model.addAttribute("pagingVO",vo);
			log.info("pagingVO={}",vo);
			List<CategoryDto>list =sellerCategoryDao.categoryGetList(vo);
			log.info("listtest={}",list);
			model.addAttribute("list",list);
			
			model.addAttribute("big",sellerCategoryDao.categoryBig());
			model.addAttribute("middle",sellerCategoryDao.categoryMiddle());
			model.addAttribute("small",sellerCategoryDao.categorySmall());
			log.info("small={}", sellerCategoryDao.categorySmall());
			return "/seller/category_insert";			
			}
			catch (Exception e) {
			e.printStackTrace();
			return "/seller/category_insert";
			}
	
	//	model.addAttribute("category_largeList", categoryDao.getList("category_large", "-"));
	//	log.info("msg");
	//	log.info("여기");
	}
	
	@PostMapping("/category_insert")
	public String seller_category_insert(Model model,
										 @ModelAttribute CategoryDto categoryDto,
										 @ModelAttribute SellerCategoryDto sellerCategoryDto,
										 HttpSession session) {
		try {
		String seller_id=(String)session.getAttribute("seller_id");//세션에서 아이디를 가져온다
	//System.out.println(categoryDto.getCategory_small());
		//small name search category no
		int category_no=sellerCategoryDao.category_no(categoryDto);//카테고리 넘버는 카테고리 디티오에 있다
		log.info("categoryno={}", category_no);
		int seller_no=sellerCategoryDao.getNo(seller_id);//셀러 넘버는 sellercategorydao에서 가져온
		log.info("sellerno={}",seller_no);
	    SellerCategoryDto sellerCategoryDto2=SellerCategoryDto.builder()
	    													 .seller_no(seller_no)
	    													  .category_no(category_no)
	    													  .build();       
	    log.info("sellerCategoryDto2={}",sellerCategoryDto2);
	    
	    sellerCategoryDao.seller_category_insert(sellerCategoryDto2);
	  
	    List<Integer> list = sellerCategoryDao.seller_category_list(seller_no);
	    log.info("list={}",list);
	    model.addAttribute("list",list);
	    List<CategoryDto> category_list =sellerCategoryDao.seller_category_name_list(list);
		//        	String seller_id=(String)session.getAttribute("seller_id");
		//			log.info("seller_id={}",seller_id);
		
		log.info("여기2");
		log.info("1={}",sellerCategoryDto2);
		log.info("2={}",sellerDto);
		//	model.addAttribute("category_largeList", categoryDao.getList("category_large", "-"));
		   
	      
	
			log.info("categoryDto={}",sellerCategoryDto);
	//			return "redirect:/seller/category_info?seller_no=" + seller_no;
		
			
			return "/seller/category_insert";
		}
		catch (Exception e) {
			e.printStackTrace();
			return "/seller/category_insert";
		}
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

