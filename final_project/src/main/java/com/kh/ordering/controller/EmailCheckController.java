package com.kh.ordering.controller;

import javax.mail.Session;
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

import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.EmailService;
import com.kh.ordering.service.RandomService;
@Controller
@RequestMapping("/seller")
public class EmailCheckController {
	@Autowired
	private EmailService emailService;

	@Autowired
	private RandomService randomService;
	@Autowired
	private SellerDto sellerDto;
	@Autowired
	private SellerDao sellerDao;
	
@GetMapping("/check")
	public String check(){     
	return "seller/check";			
}
//@PostMapping("/check")
//public String check(Model model, HttpSession session){
//	String seller_email=(String)session.getAttribute("seller_email");
//	String seller_name=(String)session.getAttribute("seller_name");//세션에 있는 이름과 이메일을 꺼낸다
//	sellerDto.setSeller_name(seller_name);
//	sellerDto.setSeller_email(seller_email);
//	SellerDto sellerDto =SellerDto.builder().seller_name(seller_name) //sellerDto에 이름과이메일을 넣는다
//																.seller_email(seller_email)
//																.build();
//	SellerDto find=sellerDao.find_id(sellerDto);//seller_name과seller_imail이 같은것을 찾는다
//      model.addAttribute("sellerDto",find);
//      return"redirect:/seller/find_id";
//	
//}
//@GetMapping("/send")//jsp로 결과가 나가면 안된다
//@ResponseBody//내가 반환하는 내용이 곧 결과물
//public String send(@RequestParam String seller_email,HttpSession session) {
////	String cert ="1236";//세션에 저장된 판매자 이름과 판매자 아이디를 넣어서 서버에 있는 아이디랑 이메일이 같다면 인증번호를 보내라 
//    	  String cert = randomService.generateCertificationNumber(6);
//    	  session.setAttribute("cert", cert);
//    	  return emailService.sendCertMessege(seller_email, cert);
//    	  
//      }
//

//	SellerDto sellerDto =SellerDto.builder().seller_name(seller_name) //sellerDto에 이름괴 이메일을 넣는다
//																.seller_email(seller_email)
//																.build();
//	SellerDto info=sellerDao.info(sellerDto);//info를 저장소info에 넣는다
//	model.addAttribute("sellerDto", info);

//@GetMapping("/validate")//세션에 있는 cert랑 사용자가 입력한 번호랑 같아야한다
//@ResponseBody
//public String validate(HttpSession session, @RequestParam String cert) {
//		String value =(String)session.getAttribute("cert");//서버에 저장된 번호를 내놔라 사용자가 입력한 값이 cert로 들어와야한다
//		      session.removeAttribute("cert");//세션값을 지운다 한번쓰면 지워야한다(버려야한다)
//		if (value.equals(cert)) {  //사용자가 입력한 값이 cert랑 같으면
//			return "success";
//		}	
//			else {
//				return "fail";
//				
//			}
//		}
//@PostMapping("/find_id")
//public String find_id(HttpSession session,Model model) {//인증 번호가 맞다면 아이디를 찍어줘라
//		
//	    String seller_email=(String)session.getAttribute("seller_email");
//		String seller_name=(String)session.getAttribute("seller_name");
//		SellerDto sellerDto =SellerDto.builder().seller_name(seller_name) //sellerDto에 이름과이메일을 넣는다
//																   .seller_email(seller_email)
//																   .build();
//		SellerDto info=sellerDao.info(sellerDto);
//		model.addAttribute("sellerDto",info);
//
//		
//		     return"seller/find_id";
//	String seller_email =sellerDto.getSeller_email();
//	String seller_id =sellerDto.getSeller_id();

//}
}
