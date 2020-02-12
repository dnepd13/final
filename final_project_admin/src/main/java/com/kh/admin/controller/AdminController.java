package com.kh.admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.entity.BlockDto;
import com.kh.admin.entity.CategoryDto;
import com.kh.admin.entity.MemberDto;
import com.kh.admin.entity.PremiumDto;
import com.kh.admin.entity.SellerDto;
import com.kh.admin.repository.AdminDao;
import com.kh.admin.repository.CategoryDao;
import com.kh.admin.repository.GoodsDao;
import com.kh.admin.repository.MemberDao;
import com.kh.admin.repository.PremiumDao;
import com.kh.admin.repository.SellerDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.vo.GoodsVO;
import com.kh.admin.vo.MemberPointVO;
import com.kh.admin.vo.PagingVO;
import com.kh.admin.vo.SellerGoodsVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminController {
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private PremiumDao premiumDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private SellerDao sellerDao;
	
	//---------------------------로그인창----------------------------------
	@GetMapping("/")
	public String login() {
		
		return "login";
	}
	//---------------------------로그인창----------------------------------
	@PostMapping("/")
	public String login(
			@ModelAttribute AdminDto adminDto,
			HttpSession session
			) {
			try {
			AdminDto login= adminDao.login(adminDto);
			
			log.info("1={}",login);
			if(login == null) {
				return "redirect:/?error";
			}
			else {
				boolean correct = passwordEncoder.matches(adminDto.getAdmin_pw(), login.getAdmin_pw());
				log.info("correct={}",correct);
				if(correct) {
					
					session.setAttribute("admin_id", login.getAdmin_id());
					session.setAttribute("admin_grade", login.getAdmin_grade());
					adminDao.lastLogin(adminDto);
					return "redirect:/home";
				}
				else {
					log.info("???");
					return "redirect:/?error";
				}
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/?error";
		}
	
	}
	//---------------------------홈창----------------------------------
	@GetMapping("/home")
	public String home() {
		return "/home";
	}
	//---------------------------관리자가입창----------------------------------
	@GetMapping("/regist")
	public String regist() {
		return "/regist";
	}
	//---------------------------관리자가입창----------------------------------
	@PostMapping("/regist")
	public String regist(@ModelAttribute AdminDto adminDto) {
		adminDto.setAdmin_pw(passwordEncoder.encode(adminDto.getAdmin_pw()));
		
		log.info(adminDto.getAdmin_id());
		log.info(adminDto.getAdmin_grade());
		log.info(adminDto.getAdmin_email());
		log.info(adminDto.getAdmin_join_date());
		log.info(adminDto.getAdmin_last_login());
		log.info(adminDto.getAdmin_name());
		log.info(adminDto.getAdmin_pw());
		adminDao.regist(adminDto);

		return "/regist";
	}
	
	//---------------------------로그아웃창----------------------------------
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("admin_id");
		session.removeAttribute("admin_grade");
		return "redirect:/";
	}
	
	//---------------------------카테고리 관리창----------------------------------
	@GetMapping("/category")
	public String category(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
		PagingVO vo = boardService.categoryPagination(pno1);
		model.addAttribute("paging",vo);
		
		List<CategoryDto> list= categoryDao.categoryGetList(vo);
		model.addAttribute("list", list);
		return "/category";
	
	}
	//---------------------------카테고리 등록----------------------------------
	@PostMapping("/category")
	public String categoryInsert(
			@ModelAttribute CategoryDto categoryDto
			) {
		categoryDao.insertCategory(categoryDto);
		return "redirect:/category";
	}
	//---------------------------카테고리 업데이트----------------------------------
	@PostMapping("/categoryUpdate")
	@ResponseBody
	public String categoryUpdate(
			@RequestParam int category_no,
			@RequestParam String category_large,
			@RequestParam String category_middle,
			@RequestParam String category_small
			) {
		
		log.info("1={}", category_no);
		log.info("1={}", category_large);
		log.info("1={}", category_middle);
		log.info("1={}", category_small);
		
		CategoryDto categoryDto = CategoryDto.builder()
																		.category_no(category_no)
																		.category_large(category_large)
																		.category_middle(category_middle)
																		.category_small(category_small)
																	.build();
		
		categoryDao.updateCategory(categoryDto);
		return "/category";
	}
	
	//---------------------------카테고리 삭제----------------------------------
	@PostMapping("/categoryDelete")
	@ResponseBody
	public String categoryDelete(
			@RequestParam int category_no
			) {
		categoryDao.deleteCategory(category_no);
		
		return "redirect:/category";
	}
	//---------------------------수수료창----------------------------------
	@GetMapping("/premium")
	public String premium(Model model) {
		List<PremiumDto> list = premiumDao.premiumGetList();
		model.addAttribute("list", list);
		return "/premium";
	}
	
	//---------------------------수수료 추가----------------------------------
	@PostMapping("/premium")
	public String premium(@ModelAttribute PremiumDto premiumDto) {
		premiumDao.premiumInsert(premiumDto);
		return "redirect:/premium";
	}
	//---------------------------수수료 변경----------------------------------
	@PostMapping("premiumUpdate")
	@ResponseBody
	public String premiumUpdate(
			@RequestParam int premium_no, 
			@RequestParam int premium_price,
			@RequestParam int premium_rate
			) {
		PremiumDto premiumDto = PremiumDto.builder()
																		.premium_no(premium_no)
																		.premium_price(premium_price)
																		.premium_rate(premium_rate)
																	.build();
		premiumDao.premiumUpdate(premiumDto);
		return "redirect:/premium";
	}
	
	
	//---------------------------수수료 삭제----------------------------------
	@PostMapping("/premiumDelete")
	@ResponseBody
	public String premiumDelete(
			@RequestParam int premium_no
			) {
		PremiumDto premiumDto = PremiumDto.builder()
																	.premium_no(premium_no)
																		.build();
		premiumDao.premiumDelete(premiumDto);
		return "redirect:/premium";
	}
	
	//---------------------------상품 리스트 뽑기----------------------------------

	@GetMapping("/goods")
	public String goods(Model model) {
		List<SellerGoodsVO> list = goodsDao.listGoods();
		log.info("list={}",list);
		model.addAttribute("list", list);
		return "/goods";
	}
	
	//resultmap을 써서 부른것
	//	@GetMapping("/goods")
//	public String goods(
//			Model model
//			) {
//		List<GoodsVO> list= goodsDao.getGoodsVO();
//		model.addAttribute("list", list);
//		return "/goods";
//	}
	
	//---------------------------차단----------------------------------
	@GetMapping("/block")
	public String block(
			@RequestParam(value = "member_no", required = false, defaultValue = "0") int member_no,
			@RequestParam(value = "seller_no", required = false, defaultValue = "0") int seller_no,
			Model model
			) {
		//member_no가 0이 멤버를 모델
		if(member_no != 0) {
			MemberDto memberDto = MemberDto.builder().member_no(member_no).build();
			MemberDto result = memberDao.memberGetOne(memberDto);
			
			model.addAttribute("id", result.getMember_id());
			model.addAttribute("no", result.getMember_no());
		}
		else {
			SellerDto sellerDto = SellerDto.builder().seller_no(seller_no).build();
			SellerDto result =  sellerDao.sellerGetOne(sellerDto);
			model.addAttribute("id", result.getSeller_id());
			model.addAttribute("no", result.getSeller_no());
		}
		
		return "/block";
	}
	
	@PostMapping("block")
	public String block(
			@ModelAttribute BlockDto blockDto
			) {
		//멤버 번호를 가지고 있으면 멤버를 차단하고 멤버리스트로 리턴
		if(blockDto.getMember_no() != 0) {
			adminDao.block(blockDto);
			return "redirect:/member/manage";
		}
		//셀러 번호를 가지고 있으면 셀러를 차단하고 셀러리스트로 리턴
		else if(blockDto.getSeller_no() != 0) {
			adminDao.block(blockDto);
			return "redirect:/seller/manage";
		}
		//아니면 오류
		else {
			return "redirect:/";
		}
	}
	
	@GetMapping("/blocklist")
	public String blocklist(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
		
			PagingVO vo = boardService.blockPagination(pno1);
			model.addAttribute("paging",vo);
			
			List<BlockDto> list = adminDao.blockList(vo);
			model.addAttribute("list", list);
				
		return "/blocklist";
	}
	
	@PostMapping("blocklist")
	public String blocklist(
			@ModelAttribute BlockDto blockDto
			) {
		adminDao.blockDelete(blockDto);
		return "redirect:/blocklist";
	}
	
}

