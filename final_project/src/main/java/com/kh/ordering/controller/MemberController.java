package com.kh.ordering.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.ordering.entity.AdminQnaDto;
import com.kh.ordering.entity.GoodsCartDto;
import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.entity.Member_AddrDto;
import com.kh.ordering.entity.Member_PointDto;
import com.kh.ordering.entity.PayDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.AdminQnaDao;
import com.kh.ordering.repository.CertDao;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.Member_AddrDao;
import com.kh.ordering.repository.Member_PointDao;
import com.kh.ordering.repository.OrderDao;
import com.kh.ordering.service.BoardQnaService;
import com.kh.ordering.service.EmailService;
import com.kh.ordering.service.GoodsOptionService;
import com.kh.ordering.service.MemberService;
import com.kh.ordering.service.RandomService;
import com.kh.ordering.vo.CartVO;
import com.kh.ordering.vo.ItemVO;
import com.kh.ordering.vo.ItemVOList;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	@Autowired
	private MemberCustomDao memberCustomDao;
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private JavaMailSender sender;
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private RandomService randomService;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private Member_PointDao member_PointDao;
	
	@Autowired
	private Member_AddrDao member_AddrDao;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private GoodsOptionService goodsOptionService;
	
	@Autowired
	private AdminQnaDao adminQnaDao;
	@Autowired
	private BoardQnaService boardQnaService;

	// 장바구니 (월용) ///////////////////////
	@GetMapping("/cart")
	public String cart(HttpSession session, Model model) throws JsonProcessingException {
		String member_id = (String)session.getAttribute("member_id");

		List<GoodsCartDto> goodsCartDtoList = memberDao.getGoodsCartList(member_id);
		List<ItemVO> itemVOList = new ArrayList<>();
		List<Integer> goodsCartNoList = new ArrayList<>();

		for(GoodsCartDto goodsCartDto : goodsCartDtoList) {
			goodsCartNoList.add(goodsCartDto.getGoods_cart_no());

			ItemVO itemVO = ItemVO.builder()
					.goods_no(goodsCartDto.getGoods_no())
					.option_no_list(memberDao.getGoodsOptionNoList(goodsCartDto.getGoods_cart_no()))
					.price(goodsCartDto.getGoods_cart_price())
					.quantity(goodsCartDto.getGoods_cart_quantity())
				.build();
			itemVOList.add(itemVO);
		}

		List<CartVO> cartVOList = goodsOptionService.getCartVOList(itemVOList);



		model.addAttribute("cartVOList", cartVOList);

		ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("jsonCartVOList", mapper.writeValueAsString(cartVOList));
		model.addAttribute("jsGoodsCartNoList", goodsCartNoList);
		
		// 파일
		List<Integer> filesList = new ArrayList<>();
		for (CartVO cartVO : cartVOList) {
			filesList.add(goodsDao.getGoodsMainImage(cartVO.getGoodsDto().getGoods_no()));
		}
		model.addAttribute("filesList", filesList);
		
		return "member/cart";
	}

	@PostMapping("/addCart")
	@ResponseBody
	public String addCart(@ModelAttribute ItemVOList itemVOList, HttpSession session) {
		memberService.addCart((String)session.getAttribute("member_id"), itemVOList);
		return "";
	}

	@PostMapping("/deleteCart")
	@ResponseBody
	public String deleteCart(@RequestParam int goods_cart_no) {
		memberService.deleteCart(goods_cart_no);
		return "";
	}


	/////////////////////////////////////	

		
	
		//회원 가입하기
	
		@GetMapping("/regist")
		public String regist() {
		return "member/regist";
		}
	
		
		@PostMapping("/regist")
		public String regist(@ModelAttribute MemberDto member) {	
			
			
			//멤버의 시퀀스 번호를 저장한다
			int seq = memberDao.MemberSeq(); 
			
			//멤버 시퀀스를  저장한다
			member.setMember_no(seq);
			
			
			//memberDto에 들어가 있는 pw를 암호화 한다(bcrypt)
			
//			//멤버의 pw를 가져오고
//			String origin= member.getMember_pw();
//			//가져온 pw를 암호화한다
//			String result = encoder.encode(origin);
//			//멤버에 pw를 넣는다
//			member.setMember_pw(result);
			member.setMember_pw(passwordEncoder.encode(member.getMember_pw()));
			
			
			//멤버 시퀀스를 회원에게 입력받은 6개의 데이터에 넣고 입력
			sqlSession.insert("member.regist",member);
			
			//멤버 포인트테이블에  불러온 시퀀스를 넣는다
			Member_PointDto member_PointDto = Member_PointDto.builder().member_no(seq).build();
			
			//시퀀스를 넣은 포인트에 데이터를 넣고 입력
			sqlSession.insert("member_PointDto.pointregist", member_PointDto);
			
			return "redirect:/member/registsuccess"; //완료후 다른페이지로 이동시 리다이렉트로 보낸다
		}

		
	//회원 탈퇴
	@GetMapping("memberdelete")
	public String memberdelete() {
		
		return "member/memberdelete";
	}

	@PostMapping("memberdelete")
	public String memberdelete(HttpSession session, @ModelAttribute MemberDto memberDto)
	{
		try {
		String member_id = (String)session.getAttribute("member_id");
		memberDto.setMember_id(member_id);
		MemberDto login = memberDao.login(memberDto);
		
		boolean correct = passwordEncoder.matches(memberDto.getMember_pw(),login.getMember_pw());
		
		if(correct) {

			memberDao.memberdelete(login);
			session.removeAttribute("member_id");
			return "redirect:/member/deleteSuccess";
		}
		else {
			return "redirect:/member/deleteFail";
		}
		}catch(Exception e) {
		e.printStackTrace();
		return "redirect:/?error";	
		}
	}
	
	//비밀번호 실패 
	@GetMapping("deleteFail")
	public String deleteFail() {
		
		return "member/deleteFail";
	}
	
	//
	
	@GetMapping("deleteSuccess")
	public String deleteSuccess() {
		
		return "member/deleteSuccess";
	}
	
	
	@GetMapping("/registsuccess")
	public String registsuccess() {
		return "member/registsuccess";//완료한뒤 인덱스페이지로 보낼것을 준비
	}

	
	
		
	// 회원 로그인	
		
	@GetMapping("/login")
	
	public String login() {
		return "member/login"; 
	}
	
	
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto member, 
			HttpSession session ) {
		
		try {
		MemberDto login = memberDao.login(member);
	
		
		
		if(login == null) {//아이디가 없으면

		//리턴 값
			return "redirect:/member/login?error";
		}
		
		else {//아이디가 있으면 비밀번호 매칭 검사
		boolean correct = passwordEncoder.matches(member.getMember_pw(), login.getMember_pw());

			if(correct) {//비밀번호 일치
				
			//세션에 회원 정보인  member_id, member_no 를 추가 
			session.setAttribute("member_id", login.getMember_id());
			session.setAttribute("member_grade", login.getMember_grade());
//			session.setAttribute("member_no", find.getMember_no());

			// 최종로그인
			memberDao.lastLogin(member);

			//필요하다면 쿠키도 생성
			
//			  session.getAttribute("member_id");
			
//			String member_id = session.getno("member_id");
//			  
//			memberDao.getNo(String member_id, member);  
			
			return "redirect:/";
		
			} else {//로그인이 실패 했을 경우 확인을 위한 구문

			return "redirect:/member/login?error";
		}
			
		}
		
		}catch(Exception e) {
		e.printStackTrace();
		return "redirect:/?error";

	
		}
	}
		
		


	//회원 로그아웃
	
	@GetMapping("/logout")
	
	public String logout(HttpSession session ) {
		
		
		session.removeAttribute("member_id");
		
//		session.removeAttribute("member_no");
		
		return "redirect:/";
	}
	
	@GetMapping("/style")
	public String style() {
		
		return "member/style";
	}

	

	
	//비밀번호 찾기 확인
	@GetMapping("/pwfind")
	public String pwfind(HttpSession session, Model model) {
		
	
		
		return "member/pwfind"; 
	}
	
	@PostMapping("pwfind")
	public String pwfind(@ModelAttribute MemberDto memberDto, HttpSession session)
	{
		MemberDto login = memberDao.emaillogin(memberDto);
		
		//세션으로 로그인을 집어넣는다
		session.setAttribute("member_id", login.getMember_id());

			memberDao.lastLogin(memberDto);
		
		return "redirect:/member/emailpwchange";
	}
	
	//이메일 비밀번호 변경 완료
	@GetMapping("/emailpwchange")
	public String emailpwchange() {

		
		return "member/emailpwchange";
		
	}	
	@PostMapping("/emailpwchange")
	public String emailpwchange(@ModelAttribute MemberDto memberDto,HttpSession session) {
		String member_id = (String)session.getAttribute("member_id"); 

		memberDto.setMember_id(member_id);

		memberDto.setMember_pw(passwordEncoder.encode(memberDto.getMember_pw()));
		memberDto.setMember_id(member_id);
		
	
			memberDao.change_pw(memberDto);
		
			session.removeAttribute("member_id");
		
			
		return"redirect:/member/login";
		}
	
	//회원 상세 정보
	@GetMapping("/memberinfo")
		public String memberinfo (HttpSession session,Model model ) {
		String member_id = (String)session.getAttribute("member_id");
		
		MemberDto memberDto = MemberDto.builder().member_id(member_id).build();
										
		
		
		MemberDto my = memberDao.membergetUpdate(memberDto);
		model.addAttribute("memberDto", my);
		
		
		return "member/memberinfo";
	}
	
	
	
	
	//회원 정보 수정
	@PostMapping("memberinfo")
	public String memberinfo(Model model,HttpSession session)
	{
		String member_id = (String)session.getAttribute("member_id");
		
		MemberDto memberDto = MemberDto.builder().member_id(member_id).build();
										
		
		
		MemberDto my = memberDao.membergetUpdate(memberDto);
		model.addAttribute("memberDto", my);
		
		return "redirect:/member/editmember";
	}
	@PostMapping("/memberedit")
	public void memberedit(@ModelAttribute MemberDto memberDto) {

	log.info("updmember={}", memberDto);
	memberDao.memberedit(memberDto);
}
	
	
	
	//회원체크
	@GetMapping("/membercheck")
	public String membercheck() {
		
		return "member/membercheck";
	}
	//3차 정보수정
		@PostMapping("/memberinfoedit")
		@ResponseBody
		public String memberinfoedit(
				@RequestParam int member_no,
				@RequestParam String member_email,
				@RequestParam String member_phone) {

		log.info("membereditn={}", member_no);
		log.info("membereditem={}", member_email);
		log.info("membereditph={}", member_phone);
		
		MemberDto memberDto = MemberDto.builder()
							.member_no(member_no)
							.member_email(member_email)
							.member_phone(member_phone)
							.build();
		
//		memberDao.memberedit(memberDto);
		return "redirect:/member/memberinfo";
		}
		

	
	
	
	
	



	
	
//회원 이메일 인증
	@PostMapping("/send")//jsp로 결과가 나가면 안된다
	@ResponseBody//내가 반환하는 내용이 곧 결과물
	public String send(@RequestParam String member_email,HttpSession session) {

		String cert = randomService.generateCertificationNumber(6);
	    	  session.setAttribute("cert", cert);
	    	
	    	  return emailService.sendCert(member_email, cert);

	      }
	@PostMapping("/validate")//세션에 있는 cert랑 사용자가 입력한 번호랑 같아야한다
	@ResponseBody
	public String validate(HttpSession session, @RequestParam String cert) {
			String value =(String)session.getAttribute("cert");//서버에 저장된 번호를 내놔라 사용자가 입력한 값이 cert로 들어와야한다
			      session.removeAttribute("cert");//세션값을 지운다 한번쓰면 지워야한다(버려야한다)
			      if (value.equals(cert)) {  //사용자가 입력한 값이 cert랑 같으면

						return "success";
			      }
			      else {
			    	  	return "fail";

				}
			}
	
	
	
	///아이디 중복검사
				@GetMapping(value = "/id_check",produces ="application/text; charset=utf-8")
				@ResponseBody //ajax
				public String id_check(String member_id, Model model) {
			 System.out.println("Controller.idCheck() 호출");
		

		int result = sqlSession.selectOne("member.id_check", member_id);
		
			String a = Integer.toString(result);
			if(result == 1) {
				return a;
			}
			else {
				return a;
			}
		   } 
	
				//-------------------아이디 찾기-------------------------//
				@GetMapping("/memberfind_id")
				public String memberfind_id() {
					return "member/memberfind_id";

				}
				
				@PostMapping("/memberfind_id")
				public String memberfind_id(HttpSession session,@RequestParam String member_email,
						@RequestParam String member_name,Model model) {

						MemberDto memberDto =MemberDto.builder().member_name(member_name)
																.member_email(member_email)
																.build();
						
						MemberDto find_id=memberDao.memberfind_id(memberDto);

						model.addAttribute("memberDto",find_id);
					return "/member/find_id_info";

			}
				@GetMapping("/find_id_info")

				public String find_id_info2(HttpSession session,@RequestParam(value = "member_email",required = false ,defaultValue = "" ) String member_email,
						@RequestParam (value = "member_name",required = false ,defaultValue = "" ) String member_name,
							Model model) {
				String name =(String)session.getAttribute("member_name");
				String email =(String)session.getAttribute("member_email");

						MemberDto memberDto =MemberDto.builder().member_name(member_name) 
																				   .member_email(member_email)
																				   .build();

						MemberDto find_id=memberDao.memberfind_id(memberDto);

					//	model.addAttribute("sellerDto",find_id);

					return "member/find_id_info";

				}
				@PostMapping("/find_id_info")

				public String find_id_info(HttpSession session,@RequestParam(value = "member_email",required = false ,defaultValue = "" ) String member_email,
						@RequestParam(value = "member_name",required = false ,defaultValue = "" ) String member_name,Model model) {
				String name =(String)session.getAttribute("member_name");
					String email =(String)session.getAttribute("member_email");
						MemberDto memberDto =MemberDto.builder().member_name(member_name) 
																				   .member_email(member_email)
																				   .build();

						MemberDto find_id=memberDao.memberfind_id(memberDto);

//						model.addAttribute("sellerDto",find_id);
					return "redirect:/member/login";
	
				}


	
	
	
	
				// 배송지  테이블 리스트

				@GetMapping("/addrinfo")
				public String addrinfo (HttpSession session,Model model ) {
					String member_id = (String)session.getAttribute("member_id");
					int member_no = memberDao.getNo(member_id);
					//	session에서 no를 저장했을때 사용	int member_no = (int) session.getAttribute("member_no");
					
					List<Member_AddrDto> list = member_AddrDao.getListAddr(member_no);
					
					model.addAttribute("addrinfo", list);
					
					
					return "member/addrinfo";
				}
				

				// 배송지 한개 테이블 리스트
	
	@GetMapping("/addrpage")
	public String addrpage(@ModelAttribute Member_AddrDto member_AddrDto, Model model) {
		
		model.addAttribute("addrone", member_AddrDao.addrGetOne(member_AddrDto));
		
		
		
		return "member/addrpage";
	}


	//배송지 정보 수정 테이블

	@GetMapping("/addrupdate")
	public String addrupdate(@RequestParam int member_addr_no,Model model)
	{

		Member_AddrDto result = member_AddrDao.addrgetUpdate(member_addr_no);
		model.addAttribute("addrupdateget",result);

		return "member/addrupdate";
	}
	

	@PostMapping("/addrupdate")
	public String addrupdate(@ModelAttribute Member_AddrDto member_AddrDto,Model model)
	{

		
		member_AddrDao.addrUpdate(member_AddrDto);

		return "redirect:/member/addrinfo";
	}
	







	// 배송지 한개 테이블 삭제

	@PostMapping("/addrdelete")
	public String addrdelete(@ModelAttribute Member_AddrDto member_AddrDto, Model model,HttpSession session) {
		
		sqlSession.delete("member_AddrDto.addrdelete", member_AddrDto);
		
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);
		
		return "redirect:/member/addrinfo";
	}
	
	
	// 배송지 한개 테이블 수정
	
	@PostMapping("/addrpage")
	public String addredit(@RequestParam int member_addr_no,
							@RequestParam String member_name_extra,
							@RequestParam String member_addr_post,
							@RequestParam String member_addr_basic,
							@RequestParam String member_addr_extra,
							@RequestParam String member_addr_status
								) {

		
		Member_AddrDto member_AddrDto = Member_AddrDto.builder()
										.member_addr_no(member_addr_no)
									    .member_name_extra(member_name_extra)
										.member_addr_post(member_addr_post)
										.member_addr_basic(member_addr_basic)
										.member_addr_extra(member_addr_extra)
										.member_addr_status(member_addr_status)
									    .build();
	
		member_AddrDao.addredit(member_AddrDto);
		
		return "redirect:/member/addrinfo";
	}

	//배송지 추가 테이블
	
	@PostMapping("/insertaddr")
	public String registaddr(@ModelAttribute Member_AddrDto member_AddrDto,
								MemberDto member,HttpSession session) {

//		// session값에 있는 아이디를 찾아서 번호를 구해왔고 
////		String member_id =(String)session.getAttribute("member");
////		int member_no = memberDao.findno("member_id");
////		
		
//		
////		member_AddrDto = Member_AddrDto.builder().member_no(member_no).build();
//		
//		//멤버 시퀀스를 회원에게 입력받은 4개의 데이터에 넣고 입력
//		//sqlSession.insert("member_AddrDto.insertaddr",member_AddrDto);
	
////		member_addrDto에 번호를 152번으로 설정한 뒤  DAO를 이용하여 insert
	
		//세션에 저장되어있는(로그인) member no를 불러온다
		
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);
		
		
//		member_AddrDto = Member_AddrDto.builder().member_no(no)
//				.member_addr_basic(member_AddrDto.getMember_addr_basic())
//				.member_addr_extra(member_AddrDto.getMember_addr_extra())
//				.member_addr_post(member_AddrDto.getMember_addr_post())
//				.member_name_extra(member_AddrDto.getMember_name_extra())
//				.build();
		//위의 코드랑 같다
	
		
		member_AddrDto.setMember_no(member_no);
			
	
		
		if(member_AddrDao.getListAddr(member_no).size()>0) {
			member_AddrDao.insertchuaddr(member_AddrDto);
		}
	else{
		member_AddrDao.insertaddr(member_AddrDto);
		}
		
			
		

		return "redirect:/member/addrinfo";
	}
	
	// 주소 List 개수 검사. 비동기.
	@GetMapping("/getAddrList")
	@ResponseBody
	public List<Member_AddrDto> getListAddr(@RequestParam int member_no) {
		log.info("member_no={}",member_no);
//		int memberNo = Integer.parseInt(member_no);
		return member_AddrDao.getListAddr(member_no);
	}
	
	//포인트를 확인 할 수 있는 게시판
	
		@GetMapping("/pointinfo")
		public String pointinfo (HttpSession session, Model model, 
											@RequestParam(value="pageNo", required=false, defaultValue="0")String pageNo,
											@ModelAttribute PagingVO pagingVO) {
			String member_id = (String)session.getAttribute("member_id");
			int member_no = memberDao.getNo(member_id);
		
			int count;
			if(pagingVO.getKey()==null || pagingVO.getKey()=="") {
				count = member_PointDao.getListCount(member_no);
				PagingVO result = memberService.pointInfoPaging(pageNo, count);
				
				result.setMember_no(member_no);
				
				model.addAttribute("paging",result);
				
				List<Member_PointDto> pointlist = member_PointDao.getListPoint(result);
				model.addAttribute("pointinfo",pointlist);
			}
			else {
				count = member_PointDao.getStatusCount(member_no, pagingVO.getKey());
				PagingVO result = memberService.pointInfoPaging(pageNo, count);
				
				result.setMember_no(member_no);
				result.setKey(pagingVO.getKey());
				
				model.addAttribute("paging",result);
				
				List<Member_PointDto> pointlist = member_PointDao.getListPoint(result);
				model.addAttribute("pointinfo",pointlist);
			}
			// 회원 현재 총 포인트
			int totalPoint= member_PointDao.getTotalPoint(member_no);
			model.addAttribute("totalPoint", totalPoint);
			
			return "member/pointinfo";
		}
		
//회원 로그인후 마이페이지
	@GetMapping("/membermyinfo")
	public String membermyinfo(Model model, HttpSession session,
												@RequestParam(value="pageNo", required=false, defaultValue="0") String pageNo) {
		
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);
		model.addAttribute("member_no", member_no);
		
		// 최근 구매내역
		List<PayDto> cartYesterDay = orderDao.getListYesterDay(member_no);
		model.addAttribute("cartYeseterDay", cartYesterDay);
		
		// 최근 문의게시판 작성내역
		PagingVO result= boardQnaService.myInfoQnaPaging(pageNo, member_no);
		model.addAttribute("paging", result);
		List<AdminQnaDto> getListYesterDay= adminQnaDao.getListYesterDay(result);
		model.addAttribute("getListYesterDay", getListYesterDay);
					
		return "member/membermyinfo";
	}
		
	
///// 회원 마이페이지 Aside에 보낼 정보
		@GetMapping("/memberInfoAside") // 전체 회원정보
		@ResponseBody
		public MemberDto memberInfoAside(HttpSession session) {
			
			String member_id = (String)session.getAttribute("member_id");
			int member_no = memberDao.getNo(member_id);
			
			MemberDto memberDto = memberDao.getMember(member_no);
			
			return memberDto;
		}
		@GetMapping("/memberPointAside")
		@ResponseBody
		public int memberPointAside(HttpSession session) {
			
			String member_id = (String)session.getAttribute("member_id");
			int member_no = memberDao.getNo(member_id);
			
			return member_PointDao.getTotalPoint(member_no);
		}
		
//////////////////////////////		
		
		
		//로그인 회원 비밀번호 변경
		@GetMapping("/check_pw")
		public String check_pw() {
			
			return "member/check_pw";
		}
		@PostMapping("/check_pw")
		public String check_pw(@ModelAttribute MemberDto memberDto,HttpSession session) {
			String member_id = (String)session.getAttribute("member_id");
			memberDto.setMember_id(member_id);
			MemberDto find = memberDao.login(memberDto);
			boolean correct = passwordEncoder.matches(memberDto.getMember_pw(), find.getMember_pw());
			if(correct==true) {
			return"redirect:/member/pwchange";
		}
			else {
				return"redirect:/member/check_pw";
			}
		}
		
		//비밀번호 확인창
		@GetMapping("/pwchangeCheck")
		public String pwchangeCheck() {
			
			return"/member/pwchangeCheck";
		}
		
		
		//비밀번호 변경 완료
		@GetMapping("/pwchange")
		public String pwchange () {

			
			return "member/pwchange";
			
		}	
		@PostMapping("/pwchange")
		public String pwchange(@ModelAttribute MemberDto memberDto,HttpSession session) {
			String member_id = (String)session.getAttribute("member_id"); 
			
				memberDto.setMember_id(member_id);
			
				memberDto.setMember_pw(passwordEncoder.encode(memberDto.getMember_pw()));
				memberDto.setMember_id(member_id);
				
				
				memberDao.change_pw(memberDto);
				
				session.removeAttribute("member_id");
			
					
				return"redirect:/member/login";
			}






}