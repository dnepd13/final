package com.kh.admin.controller;

import java.util.Calendar;
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
import com.kh.admin.entity.AdminQnaBoardDto;
import com.kh.admin.entity.BlockDto;
import com.kh.admin.entity.CategoryDto;
import com.kh.admin.entity.GradeBenefitDto;
import com.kh.admin.entity.MemberDto;
import com.kh.admin.entity.PremiumDto;
import com.kh.admin.entity.SellerDto;
import com.kh.admin.repository.AdminDao;
import com.kh.admin.repository.CategoryDao;
import com.kh.admin.repository.GoodsDao;
import com.kh.admin.repository.GradeBenefitDao;
import com.kh.admin.repository.MemberDao;
import com.kh.admin.repository.PremiumDao;
import com.kh.admin.repository.SalesDao;
import com.kh.admin.repository.SellerDao;
import com.kh.admin.service.BoardService;
import com.kh.admin.vo.GoodsCategoryVO;
import com.kh.admin.vo.GoodsVO;
import com.kh.admin.vo.MemberPointVO;
import com.kh.admin.vo.PagingVO;
import com.kh.admin.vo.ResultVO;
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
	
	@Autowired
	private GradeBenefitDao gradeBenefitDao;
	
	@Autowired
	private SalesDao salesDao;
	
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
					return "redirect:/?error=error";
				}
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/?error";
		}
	
	}
	//---------------------------홈창----------------------------------
	@GetMapping("/home")
	public String home(Model model) {
		try {
		int memberCount = memberDao.memberCount();
		int sellerCount = sellerDao.sellerCount();
		int registTodayCount = adminDao.registToday();
		model.addAttribute("memberCount", memberCount);
		model.addAttribute("sellerCount", sellerCount);
		model.addAttribute("todayRegist", registTodayCount);
		int year = Calendar.getInstance().get(Calendar.YEAR);
		int month = (Calendar.getInstance().get(Calendar.MONTH));
		log.info("year={}",year);
		log.info("month={}",month+1);
		model.addAttribute("year", year);
		model.addAttribute("month", month+1);
		
		//통계
		int a = 0;
		ResultVO result = salesDao.dailySalePrice();
		if(result != null) {
			model.addAttribute("dailySalePrice", result.getResult());
		}
		else {
			model.addAttribute("dailySalePrice", a);
		}
		
		ResultVO result1 =salesDao.todaySaleCount();
		if(result1 != null) {
			model.addAttribute("todaySaleCount", result1.getResult());
		}
		else {
			model.addAttribute("todaySaleCount", a);
		}
		
		ResultVO result2 = salesDao.thisMonthSalePrice();
		if(result2 != null) {
			model.addAttribute("thisMonthSalePrice", result2.getResult());
		}
		else {
			model.addAttribute("todaySaleCount", a);
		}
		
		ResultVO result3 = salesDao.thisMonthSaleCount();
		if(result3 != null) {
			model.addAttribute("thisMonthSaleCount", result3.getResult());
		}
		else {
			model.addAttribute("todaySaleCount", a);
		}
		
		ResultVO result4 = salesDao.thisWeekSalePrice();
		if(result4 != null) {
			model.addAttribute("thisWeekSalePrice", result4.getResult());
		}
		else {
			model.addAttribute("todaySaleCount", a);
		}
		
		ResultVO result5 = salesDao.thisWeekSaleCount();
		if(result5 != null) {
			model.addAttribute("thisWeekSaleCount", result5.getResult());
		}
		else {
			model.addAttribute("todaySaleCount", a);
		}
		
		//취소 오늘, 이번주, 이번달
		ResultVO result6 = salesDao.dailyCancel();
		if(result6 != null) {
			model.addAttribute("dailyCancel", result6.getResult());
		}
		else {
			model.addAttribute("dailyCancel", a);
		}
		
		ResultVO result7 = salesDao.thisWeekCancel();
		if(result7 != null) {
			model.addAttribute("thisWeekCancel", result7.getResult());
		}
		else {
			model.addAttribute("thisWeekCancel", a);
		}
		
		ResultVO result8 = salesDao.thisMonthCancel();
		if(result8 != null) {
			model.addAttribute("thisMonthCancel", result8.getResult());
		}
		else {
			model.addAttribute("thisMonthCancel", a);
		}
		
		return "/home";
		} catch (Exception e) {
			e.printStackTrace();
			return "/home";
		}
	}
	//---------------------------관리자가입창----------------------------------
	@GetMapping("/regist")
	public String regist() {
		return "/regist";
	}
	//---------------------------관리자가입창----------------------------------
	@PostMapping("/regist")
	public String regist(@ModelAttribute AdminDto adminDto) {
		try {
			
		
		adminDto.setAdmin_pw(passwordEncoder.encode(adminDto.getAdmin_pw()));
		
		
		adminDao.regist(adminDto);

		return "/regist";
		} catch (Exception e) {
			e.printStackTrace();
			return "/regist";
		}
	}
	
	//---------------------------로그아웃창----------------------------------
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		try {
			
		
		session.removeAttribute("admin_id");
		session.removeAttribute("admin_grade");
		return "redirect:/";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/";
		}
	}
	
	//---------------------------카테고리 관리창----------------------------------
	@GetMapping("/category")
	public String category(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
		try {
			
		PagingVO vo = boardService.categoryPagination(pno1);
		model.addAttribute("paging",vo);
		 
		List<CategoryDto> list= categoryDao.categoryGetList(vo);
		model.addAttribute("list", list);
		
		//카테고리 대 중 소 따로 따로 보내기
		model.addAttribute("big", categoryDao.categoryBig());
		model.addAttribute("middle", categoryDao.categoryMiddle());
		model.addAttribute("small", categoryDao.categorySmall());
		log.info("small={}", categoryDao.categorySmall());
		return "/category";
		} catch (Exception e) {
			e.printStackTrace();
			return "/category";
		}
	
	}
	//---------------------------카테고리 등록----------------------------------
	@PostMapping("/category")
	public String categoryInsert(
			@ModelAttribute CategoryDto categoryDto
			) {
		try {
			
		categoryDao.insertCategory(categoryDto);
		return "redirect:/category";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/category";
		}
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
		try {
			
		
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
		} catch (Exception e) {
			e.printStackTrace();
			return "/category";
			
		}
	}
	
	//---------------------------카테고리 삭제----------------------------------
	@PostMapping("/categoryDelete")
	@ResponseBody
	public String categoryDelete(
			@RequestParam int category_no
			) {
		try {
			
		
		categoryDao.deleteCategory(category_no);
		
		return "redirect:/category";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/category";
		}
	}
	//---------------------------수수료창----------------------------------
	@GetMapping("/premium")
	public String premium(Model model) {
		try {
			
		List<PremiumDto> list = premiumDao.premiumGetList();
		model.addAttribute("list", list);
		return "/premium";
		} catch (Exception e) {
			e.printStackTrace();
			return "/premium";
		}
	}
	
	//---------------------------수수료 추가----------------------------------
	@PostMapping("/premium")
	public String premium(@ModelAttribute PremiumDto premiumDto) {
		try {
			
		premiumDao.premiumInsert(premiumDto);
		return "redirect:/premium";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/premium";
		}
	}
	//---------------------------수수료 변경----------------------------------
	@PostMapping("premiumUpdate")
	@ResponseBody
	public String premiumUpdate(
			@RequestParam int premium_no, 
			@RequestParam int premium_price,
			@RequestParam int premium_rate
			) {
		try {
			
		PremiumDto premiumDto = PremiumDto.builder()
																		.premium_no(premium_no)
																		.premium_price(premium_price)
																		.premium_rate(premium_rate)
																	.build();
		premiumDao.premiumUpdate(premiumDto);
		return "redirect:/premium";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/premium";
		}
	}
	
	
	//---------------------------수수료 삭제----------------------------------
	@PostMapping("/premiumDelete")
	@ResponseBody
	public String premiumDelete(
			@RequestParam int premium_no
			) {
		try {
			
		PremiumDto premiumDto = PremiumDto.builder()
																	.premium_no(premium_no)
																		.build();
		premiumDao.premiumDelete(premiumDto);
		return "redirect:/premium";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/premium";
		}
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
		try {
			
		
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
		} catch (Exception e) {
			e.printStackTrace();
			return "/block";
		}
	}
	
	@PostMapping("block")
	public String block(
			@ModelAttribute BlockDto blockDto
			) {
		//멤버 번호를 가지고 있으면 멤버를 차단하고 멤버리스트로 리턴
		try {
			
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
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/";
		}
	}
	
	// ----------------------------차단 리스트 -----------------------------------
	@GetMapping("/blocklist")
	public String blocklist(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1,
			@ModelAttribute PagingVO paging
			) {
		try {
			
			int count;
			if(paging.getKey()==null) {
				count = adminDao.blockCount();
				
				PagingVO vo = boardService.allPaging(pno1, count);
				model.addAttribute("paging",vo);
				
				List<BlockDto> list = adminDao.blockList(vo);
				model.addAttribute("list", list);
				return "/blocklist";
			}
			
			else if(paging.getKey().equalsIgnoreCase("block_group")) {
				String block_group = paging.getSearch();
				count = adminDao.blockGroupCount(block_group);
				
				PagingVO vo = boardService.allPaging(pno1, count);
				model.addAttribute("paging",vo);
				vo.setKey(paging.getKey());
				vo.setSearch(paging.getSearch());
				
				List<BlockDto> list = adminDao.blockList(vo);
				model.addAttribute("list", list);
				return "/blocklist";
			}
			else if(paging.getKey().equalsIgnoreCase("block_id")) {
				String block_id = paging.getSearch();
				count = adminDao.blockIdCount(block_id);
				
				PagingVO vo = boardService.allPaging(pno1, count);
				model.addAttribute("paging",vo);
				vo.setKey(paging.getKey());
				vo.setSearch(paging.getSearch());
				
				List<BlockDto> list = adminDao.blockList(vo);
				model.addAttribute("list", list);
				return "/blocklist";
			}
			else {
				
				return "/blocklist";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "/blocklist";
		}
	}
	
	@PostMapping("/blocklist")
	public String blocklist(
			@ModelAttribute BlockDto blockDto
			) {
		try {
			
		adminDao.blockDelete(blockDto);
		return "redirect:/blocklist";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/blocklist";
		}
	}
	
	//----------------차단 해제------------------------------
	@GetMapping("/unlock")
	public String unlock(
			@RequestParam(value="seller_no", required = false, defaultValue = "0") int seller_no,
			@RequestParam(value="member_no", required = false, defaultValue = "0") int member_no
			) {
		try {
			
		
			BlockDto blockDto = new BlockDto();
				if(seller_no != 0) {
					blockDto.setSeller_no(seller_no);
					adminDao.blockUnlockSeller(blockDto);
					return "redirect:/seller/manage";
				}
				else if(member_no !=0) {
					blockDto.setMember_no(member_no);
					adminDao.blockUnlockMember(blockDto);
					return "redirect:/member/manage";
				}
				else {
					return "redirect:/blocklist";
				}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/blocklist";
		}
	}
	
	
	//--------------------등급 혜택 --------------------------------------
	@GetMapping("/gradebenefit")
	public String benefit(Model model) {
		try {
			
		model.addAttribute("list", gradeBenefitDao.gradeBenefitList());
		return "gradebenefit";
		} catch (Exception e) {
			e.printStackTrace();
			return "gradebenefit";
		}
	}
	
	@PostMapping("/gradebenefit")
	public String benefit(@ModelAttribute GradeBenefitDto gradeBenefitDto) {
		try {
			
		gradeBenefitDao.gradeBenefitRegist(gradeBenefitDto);
		
		return "redirect:gradebenefit";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:gradebenefit";
		}
	}
	
	//------------------등급혜택 수정-----------------------------------
	@PostMapping("/gradebenefitupdate")
	public void gradebenefitupdate(@ModelAttribute GradeBenefitDto gradeBenefitDto) {
		try {
			
		log.info("bene={}", gradeBenefitDto);
		gradeBenefitDao.gradeBenefitUpdate(gradeBenefitDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//--------------등급혜택 삭제------------------------------------------
	@PostMapping("gradebenefitdelete")
	public void gradebenefitdelete(@ModelAttribute GradeBenefitDto gradeBenefitDto) {
		try {
			
		gradeBenefitDao.gradeBenefitDelete(gradeBenefitDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//---------------------사이트 기본정보 설정--------------------------
	@GetMapping("/basicpagesetting")
	public String basicpagesetting() {
		try {
			
		return "basicpagesetting";
		} catch (Exception e) {
			e.printStackTrace();
			return "basicpagesetting";
		}
	}
	
	//---------------------헤더-------------------------
//	@GetMapping("/template/header")
//	public String header() {
//		return "template/header";
//	}
//	
	
	//------------------------연습용 별
//	@GetMapping("/star")
//	public String star() {
//		return "star";
//	}
//	
//	@PostMapping("/star")
//	public String star(@RequestParam int goods_review_star) {
//		log.info("star={}", goods_review_star);
//		return "star";
//	}
	
}

