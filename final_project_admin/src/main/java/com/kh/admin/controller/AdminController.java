package com.kh.admin.controller;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
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
import com.kh.admin.entity.CompanyInfoDto;
import com.kh.admin.entity.GradeBenefitDto;
import com.kh.admin.entity.MemberDto;
import com.kh.admin.entity.PremiumDto;
import com.kh.admin.entity.SellerDto;
import com.kh.admin.repository.AdminDao;
import com.kh.admin.repository.CategoryDao;
import com.kh.admin.repository.CompanyInfoDao;
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
	
	@Autowired
	private CompanyInfoDao companyInfoDao;
	
	//---------------------------濡쒓렇�씤李�----------------------------------
	@GetMapping("/")
	public String login() {
		
		return "login";
	}
	//---------------------------濡쒓렇�씤李�----------------------------------
	@PostMapping("/")
	public String login(
			@ModelAttribute AdminDto adminDto,
			HttpSession session
			) {
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
	}
	//---------------------------�솃李�----------------------------------
	@GetMapping("/home")
	public String home(Model model) {
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
		
		//�넻怨�
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
		
		//痍⑥냼 �삤�뒛, �씠踰덉＜, �씠踰덈떖
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
	}
	//---------------------------愿�由ъ옄媛��엯李�----------------------------------
	@GetMapping("/regist")
	public String regist() {
		return "/regist";
	}
	//---------------------------愿�由ъ옄媛��엯李�----------------------------------
	@PostMapping("/regist")
	public String regist(@ModelAttribute AdminDto adminDto) {
			
		
		adminDto.setAdmin_pw(passwordEncoder.encode(adminDto.getAdmin_pw()));
		
		
		adminDao.regist(adminDto);

		return "/regist";
	}
	
	//---------------------------濡쒓렇�븘�썐李�----------------------------------
	@GetMapping("/logout")
	public String logout(HttpSession session) {
			
		
		session.removeAttribute("admin_id");
		session.removeAttribute("admin_grade");
		return "redirect:/";
	}
	
	//---------------------------移댄뀒怨좊━ 愿�由ъ갹----------------------------------
	@GetMapping("/category")
	public String category(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1
			) {
			
		PagingVO vo = boardService.categoryPagination(pno1);
		model.addAttribute("paging",vo);
		 
		List<CategoryDto> list= categoryDao.categoryGetList(vo);
		model.addAttribute("list", list);
		
		//移댄뀒怨좊━ �� 以� �냼 �뵲濡� �뵲濡� 蹂대궡湲�
		model.addAttribute("big", categoryDao.categoryBig());
		model.addAttribute("middle", categoryDao.categoryMiddle());
		model.addAttribute("small", categoryDao.categorySmall());
		log.info("small={}", categoryDao.categorySmall());
		return "/category";
	
	}
	//---------------------------移댄뀒怨좊━ �벑濡�----------------------------------
	@PostMapping("/category")
	public String categoryInsert(
			@ModelAttribute CategoryDto categoryDto
			) {
			
		categoryDao.insertCategory(categoryDto);
		return "redirect:/category";
	}
	//---------------------------移댄뀒怨좊━ �뾽�뜲�씠�듃----------------------------------
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
	
	//---------------------------移댄뀒怨좊━ �궘�젣----------------------------------
	@PostMapping("/categoryDelete")
	@ResponseBody
	public String categoryDelete(
			@RequestParam int category_no
			) {
			
		
		categoryDao.deleteCategory(category_no);
		
		return "redirect:/category";
	}
	//---------------------------�닔�닔猷뚯갹----------------------------------
	@GetMapping("/premium")
	public String premium(Model model) {
			
		List<PremiumDto> list = premiumDao.premiumGetList();
		model.addAttribute("list", list);
		return "/premium";
	}
	
	//---------------------------�닔�닔猷� 異붽�----------------------------------
	@PostMapping("/premium")
	public String premium(@ModelAttribute PremiumDto premiumDto) {
			
		premiumDao.premiumInsert(premiumDto);
		return "redirect:/premium";
	}
	//---------------------------�닔�닔猷� 蹂�寃�----------------------------------
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
	
	
	//---------------------------�닔�닔猷� �궘�젣----------------------------------
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
	
	
	
	//resultmap�쓣 �뜥�꽌 遺�瑜멸쾬
	//	@GetMapping("/goods")
//	public String goods(
//			Model model
//			) {
//		List<GoodsVO> list= goodsDao.getGoodsVO();
//		model.addAttribute("list", list);
//		return "/goods";
//	}
	
	//---------------------------李⑤떒----------------------------------
	@GetMapping("/block")
	public String block(
			@RequestParam(value = "member_no", required = false, defaultValue = "0") int member_no,
			@RequestParam(value = "seller_no", required = false, defaultValue = "0") int seller_no,
			Model model
			) {
		
		//member_no媛� 0�씠 硫ㅻ쾭瑜� 紐⑤뜽
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
		//硫ㅻ쾭 踰덊샇瑜� 媛�吏�怨� �엳�쑝硫� 硫ㅻ쾭瑜� 李⑤떒�븯怨� 硫ㅻ쾭由ъ뒪�듃濡� 由ы꽩
			
		if(blockDto.getMember_no() != 0) {
			adminDao.block(blockDto);
			return "redirect:/member/manage";
		}
		//���윭 踰덊샇瑜� 媛�吏�怨� �엳�쑝硫� ���윭瑜� 李⑤떒�븯怨� ���윭由ъ뒪�듃濡� 由ы꽩
		else if(blockDto.getSeller_no() != 0) {
			adminDao.block(blockDto);
			return "redirect:/seller/manage";
		}
		//�븘�땲硫� �삤瑜�
		else {
			return "redirect:/";
		}
	}
	
	// ----------------------------李⑤떒 由ъ뒪�듃 -----------------------------------
	@GetMapping("/blocklist")
	public String blocklist(
			Model model,
			@RequestParam(value="pno1", required = false) String pno1,
			@ModelAttribute PagingVO paging
			) {
			
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
	}
	
	@PostMapping("/blocklist")
	public String blocklist(
			@ModelAttribute BlockDto blockDto
			) {
			
		adminDao.blockDelete(blockDto);
		return "redirect:/blocklist";
	}
	
	//----------------李⑤떒 �빐�젣------------------------------
	@GetMapping("/unlock")
	public String unlock(
			@RequestParam(value="seller_no", required = false, defaultValue = "0") int seller_no,
			@RequestParam(value="member_no", required = false, defaultValue = "0") int member_no
			) {
		
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
	}
	
	
	//--------------------�벑湲� �삙�깮 --------------------------------------
	@GetMapping("/gradebenefit")
	public String benefit(Model model) {
			
		model.addAttribute("list", gradeBenefitDao.gradeBenefitList());
		return "gradebenefit";
	}
	
	@PostMapping("/gradebenefit")
	public String benefit(@ModelAttribute GradeBenefitDto gradeBenefitDto) {
			
		gradeBenefitDao.gradeBenefitRegist(gradeBenefitDto);
		
		return "redirect:gradebenefit";
	}
	
	//------------------�벑湲됲삙�깮 �닔�젙-----------------------------------
	@PostMapping("/gradebenefitupdate")
	public void gradebenefitupdate(@ModelAttribute GradeBenefitDto gradeBenefitDto) {
			
		log.info("bene={}", gradeBenefitDto);
		gradeBenefitDao.gradeBenefitUpdate(gradeBenefitDto);
	}
	
	//--------------�벑湲됲삙�깮 �궘�젣------------------------------------------
	@PostMapping("gradebenefitdelete")
	public void gradebenefitdelete(@ModelAttribute GradeBenefitDto gradeBenefitDto) {
			
		gradeBenefitDao.gradeBenefitDelete(gradeBenefitDto);
	}
	
	//---------------------�궗�씠�듃 湲곕낯�젙蹂� �꽕�젙--------------------------
	@GetMapping("/basicpagesetting")
	public String basicpagesetting(
			Model model
			) {
			model.addAttribute("list", companyInfoDao.get());
			
		return "basicpagesetting";
	}
	
	@PostMapping("/basicpagesetting")
	public String basicpagesetting(
			@ModelAttribute CompanyInfoDto companyInfoDto
			) {
		
		companyInfoDao.update(companyInfoDto);
		
		return "redirect:/basicpagesetting";
	}
	
	@PostMapping("/idcheck")
	@ResponseBody
	public int idcheck(@RequestParam String admin_id) {
		
		int result = adminDao.idcheck(admin_id);
		
		//아이디가 중복이 안됨
		if(result == 0) {
			return 1;
		}
		else {
			return 0;
		}
	}
	
	@GetMapping("/error1")
	public String error1() {
		int a = 10/0;
		return "error1";
	}
	
	//이건 예외 처리 됨
	
//	@ExceptionHandler(Exception.class)//예외 처리기
//	public String handler(Exception ex) {//예외 객체
//		return "error/500";
//	}
	
	
	
//	
	//---------------------�뿤�뜑-------------------------
//	@GetMapping("/template/header")
//	public String header() {
//		return "template/header";
//	}
//	
	
	//------------------------�뿰�뒿�슜 蹂�
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

