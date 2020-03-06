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
import com.kh.ordering.entity.GoodsCartDto;
import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.entity.Member_AddrDto;
import com.kh.ordering.entity.Member_PointDto;
import com.kh.ordering.repository.CertDao;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.MemberCustomDao;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.Member_AddrDao;
import com.kh.ordering.repository.Member_PointDao;
import com.kh.ordering.service.EmailService;
import com.kh.ordering.service.GoodsOptionService;
import com.kh.ordering.service.MemberService;
import com.kh.ordering.service.RandomService;
import com.kh.ordering.vo.CartVO;
import com.kh.ordering.vo.ItemVO;
import com.kh.ordering.vo.ItemVOList;

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
			
			return "redirect:/member/login"; //완료후 다른페이지로 이동시 리다이렉트로 보낸다
		}
	
	//회원 탈퇴
	@GetMapping("memberdelete")
	public String memberdelete() {
		
		return "member/memberdelete";
	}

	@PostMapping("memberdelete")
	public String memberdelete(HttpSession session, @ModelAttribute MemberDto memberDto)
	{
		String member_id = (String)session.getAttribute("member_id");
		memberDto.setMember_id(member_id);
		MemberDto login = memberDao.login(memberDto);
		
		boolean correct = passwordEncoder.matches(memberDto.getMember_pw(),login.getMember_pw());
		
		if(login == null) {
			return "redirect:/ordering/member/membermyinfo";
		}
		else {
			session.invalidate();
			memberDao.memberdelete(login);
			return "redirect:/";
		}
	}
	
	
//	@GetMapping("/registsuccess")
//	public String registsuccess() {
//		return "member/registsuccess";//완료한뒤 인덱스페이지로 보낼것을 준비
//	}
//	
//	@PostMapping("/registsuccess")
//	public String registsuccess(
//			@ModelAttribute Member_PointDto member_pointDto) {
//	
//	member_PointDao.registsuccess(member_pointDto);
//		
//		
//		return "redirect:home"; //완료후 다른페이지로 이동시 리다이렉트로 보낸다
//	}	
	
	
		
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
		log.info("member={}", login);
		
		
		if(login == null) {//아이디가 없으면

			return "redirect:/member/login?error";
		}
		
		else {//아이디가 있으면 비밀번호 매칭 검사
		boolean correct = passwordEncoder.matches(member.getMember_pw(), login.getMember_pw());
		log.info("correct={}",correct);
			if(correct) {//비밀번호 일치
				
			log.info("로그인 성공");
			//세션에 회원 정보인  member_id, member_no 를 추가 
			session.setAttribute("member_id", login.getMember_id());
			session.setAttribute("member_grade", login.getMember_grade());
//			session.setAttribute("member_no", find.getMember_no());
			log.info("no ={}",login.getMember_no());

			// 최종로그인
			memberDao.lastLogin(member);
			log.info("1={}", login);
			//필요하다면 쿠키도 생성
			
//			  session.getAttribute("member_id");
			
//			String member_id = session.getno("member_id");
//			  
//			memberDao.getNo(String member_id, member);  
//			
			
			log.info("member={}",member);
			
			return "redirect:/";
		
			} else {//로그인이 실패 했을 경우 확인을 위한 구문
			
			
			log.info("로그인 실패");
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
		log.info("session ={}", session);
		
//		session.removeAttribute("member_no");
		
		return "redirect:/";
	}
	
	@GetMapping("/style")
	public String style() {
		
		return "member/style";
	}

	
	//회원 상세 정보
	@GetMapping("/memberinfo")
		public String memberinfo(@ModelAttribute MemberDto member,
								Model model,HttpSession session) {
		
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);			
		log.info("q= {}", member_no);
		
		member = MemberDto.builder()
							.member_no(member_no)
							.build();
		log.info("q= {}",member);
		
//		List<MemberDto> memberlist = memberDao.memberGetOne(member_no);
//		log.info("q= {}", memberlist);		
	  
	model.addAttribute("memberGetOne",memberDao.memberGetOne(member));
	log.info("q= {}", member);
//		model.addAttribute("memberGetOne",memberlist);
		
		return "member/memberinfo";
	}
	
	//회원 비밀번호 수정
	@GetMapping("/memberchange_pw")
	public String memberchange_pw() {
		
		return "member/memberchange_pw"; 
	}
	
	@PostMapping("memberchange_pw")
	public String memberchange_pw(@ModelAttribute MemberDto memberDto, HttpSession session)
	{
		String member_id = (String)session.getAttribute("member_id");
		memberDto.setMember_id(member_id);
		
		memberDto.setMember_pw(passwordEncoder.encode(memberDto.getMember_pw()));
		memberDto.setMember_id(member_id);
		
		
		memberDao.memberchange_pw(memberDto);
		
		return "redirect:/member/memberchange_pw_success";
	}
	
	//회원 정보 수정
	@GetMapping("editmember")
	public String editmember(@RequestParam int member_no,Model model)
	{
	
		MemberDto member = memberDao.memberGetOne(member_no);
		model.addAttribute("memberget",member);
		
		
		return "member/editmember";
	}
	
	//회원 정보 수정
	@PostMapping("editmember")
	public String editmember(@ModelAttribute MemberDto member) {
		
		log.info("memberPost={}", member);
		
//		MemberDto member = MemberDto.builder()
//					.member_no(member_no)
//					.member_email(member_email)
//					.member_phone(member_phone)
//					.build();

		

		
		log.info("mymember111={}",member);
		
		
		memberDao.memberedit(member);
		
		return "redirect:/member/memberinfo";
	}
	
	
//	//회원 탈퇴
//	
//	@PostMapping("/memberdelete")
//	public String memberdelete(@ModelAttribute MemberDto member,
//								Model model, HttpSession session) {
//		
//		String member_id = (String)session.getAttribute("member_id");
//		int member_no = memberDao.getNo(member_id);
//		
//		sqlSession.delete("member.memberdelete", member);
//		
//		
//		return "redirect:/memberdeletesuccess";
//	}
	
	
	//회원체크
	@GetMapping("/membercheck")
	public String membercheck() {
		
		return "member/membercheck";
	}
	
	
	
	
	
	



	
	
//회원 이메일 인증
	@PostMapping("/send")//jsp로 결과가 나가면 안된다
	@ResponseBody//내가 반환하는 내용이 곧 결과물
	public String send(@RequestParam String member_email,HttpSession session) {
//		String cert ="1236";//세션에 저장된 판매자 이름과 판매자 아이디를 넣어서 서버에 있는 아이디랑 이메일이 같다면 인증번호를 보내라 
	    System.out.println("member email"+member_email);	 
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
			log.info("들어오나");
			log.info("membercheck={}",member_id);
			
			log.info("result={}", result);
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
						log.info("1= {}", member_email);
						log.info("2= {}", member_name);
						MemberDto memberDto =MemberDto.builder().member_name(member_name)
																.member_email(member_email)
																.build();
						
						log.info("memberDto={}",memberDto);
						
						MemberDto find_id=memberDao.memberfind_id(memberDto);
						log.info("2find_id={}",memberDto);
						log.info("2find_id={}",find_id);
						model.addAttribute("memberDto",find_id);
					return "member/find_id_info";

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
						log.info("memberDto={}",memberDto);
						MemberDto find_id=memberDao.memberfind_id(memberDto);
							log.info("find_id={}",find_id);
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
						log.info("memberDto={}",memberDto);
						MemberDto find_id=memberDao.memberfind_id(memberDto);
						log.info("find_id={}",find_id);
//						model.addAttribute("sellerDto",find_id);
					return "redirect:/member/login";
	
				}
	
//	@GetMapping("/input")
//	public String input() {
//		return "pw/input";
//	}
//
//	@PostMapping("/input")
//	public String input(@RequestParam String email) throws MessagingException {
//		//1. 랜덤번호를 3자리 생성
//		String cert = randomService.generateCertificationNumber(3);
//		//2. DB에 랜덤번호/이메일/시각을 저장
//
//		certDao.certregist(CertDto.builder().email(email).cert_no(cert).build());
//	
//		//3. 이메일 전송
//		MimeMessage message = sender.createMimeMessage();
//		MimeMessageHelper helper = 
//				new MimeMessageHelper(message, true, "UTF-8");
//
//		helper.setTo(email);
//		helper.setSubject("[KH정보교육원] 비밀번호 변경 메일");
//
//		String url = "http://localhost:8080/sts21/pw/change?cert="+cert;
//
//		StringBuffer buffer = new StringBuffer();
//		buffer.append("<h1>비밀번호 변경을 위해 하단 링크를 누르세요</h1>");
//		buffer.append("<h2>");
//		buffer.append("<a href='");
//		buffer.append(url);
//		buffer.append("'>");
//		buffer.append("이동");
//		buffer.append("</a>");
//		buffer.append("</h2>");
//
//		helper.setText(buffer.toString(), true);
//
//		sender.send(message);
//
//		//4. 사용자 화면 전환
//		
//		emailService.sendChangePasswordMail(email);
//		
//		
//		return "redirect:member/result";
//	}
//	
//	@GetMapping("/result")
//	public String result(){
//		return "member/result";
//	}
//
//	@GetMapping("/change")
//	public String change(
//			@RequestParam String cert,
//			@RequestParam String email,
//			HttpServletResponse response) { 
//		boolean enter = certDao.certcheck(email, cert);
//		log.info("enter = {}", enter);
//		certDao.certdelete(email);
//		if(!enter) {
//			//에러 코드 송출
//			response.setStatus(403);
//		}
//		
//		return "member/change";
//	}



	
	
	
	
	
	
	
	
	
	
	
	
	
	
				// 배송지  테이블 리스트

				@GetMapping("/addrinfo")
				public String addrinfo (HttpSession session,Model model ) {
					String member_id = (String)session.getAttribute("member_id");
					int member_no = memberDao.getNo(member_id);
					//	session에서 no를 저장했을때 사용	int member_no = (int) session.getAttribute("member_no");
					
					List<Member_AddrDto> list = member_AddrDao.getListAddr(member_no);
					log.info("list={}",list);
					
					model.addAttribute("addrinfo", list);
					
					
					return "member/addrinfo";
				}
				
				
				//배송지 1/1보기
//				@GetMapping("/addrpage")
//				public String addrpage() {
//					
//					return "member/addrpage";
//				}
				
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

	//배송지 추가 테이블
	@PostMapping("/addregist")
	public String addrregist(@ModelAttribute Member_AddrDto member_AddrDto,
							HttpSession session, Model model)
	{
		String member_id = (String)session.getAttribute("member_id");
		int member_no = memberDao.getNo(member_id);

		member_AddrDto.setMember_no(member_no);

		member_AddrDao.addrregist(member_AddrDto);

		return "redirect:/addrinfo";
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
		log.info("view={}",member_addr_no);
		log.info("view={}",member_name_extra);
		log.info("view={}",member_addr_post);
		log.info("view={}",member_addr_basic);
		log.info("view={}",member_addr_extra);
		log.info("view={}",member_addr_status);
		
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
	
	@GetMapping("/insertaddr")
	public String registaddr() {
		
		return "member/insertaddr";
	}
	
	@PostMapping("/insertaddr")
	public String registaddr(@ModelAttribute Member_AddrDto member_AddrDto,
								MemberDto member,HttpSession session) {
//		// session값에 있는 아이디를 찾아서 번호를 구해왔고 
////		String member_id =(String)session.getAttribute("member");
////		int member_no = memberDao.findno("member_id");
////		
////		log.info("member={}",member_no);		
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
			
		log.info("no={}", member_no);
		
		member_AddrDao.insertaddr(member_AddrDto);
//		log.info("member_AddrDto={}",member_AddrDto);
		return "redirect:/member/insertaddr";
	}
		
	
	//포인트를 확인 할 수 있는 게시판
	
		@GetMapping("/pointinfo")
		public String pointinfo (HttpSession session, Model model ) {
			String member_id = (String)session.getAttribute("member_id");
			int member_no = memberDao.getNo(member_id);
			
			List<Member_PointDto> pointlist = member_PointDao.getListPoint(member_no);
			log.info("pointlist={}",pointlist);
			
			model.addAttribute("pointinfo",pointlist);
			
			return "member/pointinfo";
		}
		
	
		//회원 로그인후 마이페이지
		@GetMapping("/membermyinfo")
		public String membermyinfo(HttpSession session, Model model) {
			
			String member_id = (String)session.getAttribute("member_id");
			int member_no = memberDao.getNo(member_id);
			
			// 회원 신규 견적서 알람 check N count 개수		
			model.addAttribute("customAlarm", memberCustomDao.customAlarm(member_no));
			
			return "member/membermyinfo";
		}
	
	
	
	
}