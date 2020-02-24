package com.kh.admin;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.entity.GradeBenefitDto;
import com.kh.admin.entity.PremiumDto;
import com.kh.admin.entity.SellerDto;
import com.kh.admin.repository.AdminDao;
import com.kh.admin.repository.CalculateDao;
import com.kh.admin.repository.GradeBenefitDao;
import com.kh.admin.repository.PremiumDao;
import com.kh.admin.repository.SellerDao;
import com.kh.admin.vo.AdjustmentFullVO;
import com.kh.admin.vo.AdjustmentInsertVO;
import com.kh.admin.vo.AdjustmentVO;
import com.kh.admin.vo.CalculateVO;
import com.kh.admin.vo.FinalCalculateVO;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;
import java.util.*;
import java.text.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class Test01 {
	@Autowired
	GradeBenefitDao gradeBenefitDao;
	
	@Autowired
	AdminDao loginDao;
	
	@Autowired
	private SellerDao sellerDao;
	
	@Autowired
	private CalculateDao calculateDao;
	
	@Autowired
	private PremiumDao premiumDao;
	
	
//	public void test() {
//		AdjustmentInsertVO vo = AdjustmentInsertVO.builder().year(2020).month(2).build();
//		List<AdjustmentVO> finalCal = new ArrayList<>();
//		List<String> a = calculateDao.calculateGetSeller(vo);
//		for(int i=0; i<a.size(); i++) {
//			AdjustmentVO resultvo = new AdjustmentVO();
//			vo.setSeller_id(a.get(i));
//			String seller_id = vo.getSeller_id();
//			List<AdjustmentFullVO> b = new ArrayList<>();
//			b = calculateDao.getCalculate(vo);
//			log.info("b={}",b);
//			log.info("bsize={}",b.size());
//			int total = 0;	
//				for(int j=0; j < b.size(); j++) {
//					
//					log.info("b.get(j).getOdering_status()={}",b.get(j).getOrdering_status());
//					if(b.get(j).getOrdering_status().equals("결제완료")) {
//						total += b.get(j).getCart_info_goods_quantity() * b.get(j).getCart_info_goods_price();
//						log.info("total1={}",b.get(j).getCart_info_goods_quantity() * b.get(j).getCart_info_goods_price());
//					}
//					else {
//						total -= b.get(j).getCart_info_goods_quantity() * b.get(j).getCart_info_goods_price();
//						log.info("total2={}",b.get(j).getCart_info_goods_quantity() * b.get(j).getCart_info_goods_price());
//					}
//					log.info("total={}",total);
//				}
//			int rate = calculateDao.getRate(total);
//			int fee = total * rate / 100;
//			int adjustment_price = total - fee;
//			resultvo.setFee(fee);
//			resultvo.setAdjustment_price(adjustment_price);
//			resultvo.setRate(rate);	
//			resultvo.setTotal_cal_price(total);
//			resultvo.setSeller_id(seller_id);
//			log.info("result={}", resultvo.getTotal_cal_price());
//			finalCal.add(resultvo);
//		}	
//		log.info("final={}", finalCal);
//		}
	
//	@Test
//	public void test() {
//		int a = premiumDao.calculratePremium(500000);
//		log.info("a={}",a);
//	}
	
//	@Test
//	public void test() {
//		List<PremiumDto> pre = premiumDao.getPremium();
//		int a = 3000;
//		if(a > pre.get(0).getPremium_price()) {
//			log.info("1qjs");
//		}
//		for(int i = 1; i<pre.size()-1; i++) {
//		else if(a>pre.get(i).getPremium_price()) {
//			log.info("어디={}", i);
//		}
//		}
//	}
//	
////	@Test
////	public void test() {
////		List<FinalCalculateVO> finish = new ArrayList<>();
//		List<String> name = calculateDao.sellerCollect();
//		
//		for(int i = 0; i<name.size();i++) {
//			String id = name.get(i);
//			log.info("name={}",name);
//			List<CalculateVO> vo = new ArrayList<>();
//					vo=calculateDao.calculate(id);
//			log.info("vo={}", vo);
//			if(!vo.isEmpty()) {
//				
//				int total = 0;
//				for(int j =0; j < vo.size(); j++ ) {
//					int qu = vo.get(j).getCart_info_goods_quantity();
//					log.info("qu={}",qu);
//					int pri = vo.get(j).getCart_info_goods_price();
//					log.info("pri={}",pri);
//					total += qu*pri;
//				}
//				log.info("total={}",total);
//				FinalCalculateVO cal = new FinalCalculateVO();
//				cal.setSeller_bank_account(vo.get(0).getSeller_bank_account());
//				cal.setSeller_bank_code(vo.get(0).getSeller_bank_code());
//				cal.setSeller_bank_username(vo.get(0).getSeller_bank_username());
//				cal.setSeller_email(vo.get(0).getSeller_email());
//				cal.setSeller_id(vo.get(0).getSeller_id());
//				cal.setSeller_name(vo.get(0).getSeller_name());
//				cal.setSeller_phone(vo.get(0).getSeller_phone());
//				cal.setSeller_store_name(vo.get(0).getSeller_store_name());
//				cal.setTotal(total);
//				log.info("vo.get(0).getSeller_bank_account()={}", vo.get(0).getSeller_bank_account());
//				log.info("cal={}",cal);
//				finish.add(cal);
//			}
//		}
//		log.info("finish={}", finish);
//	}
//	
//	@Test
//	public void test() {
//		List<String> list = calculateDao.sellerCollect();
//		List<CalculateVO> result = new ArrayList<>();
//		List<CalculateVO> vo = new ArrayList<>
//		for(int i = 0; i < list.size(); i++) {
//			String id = list.get(i);
//			log.info("id={}",id);
//			 vo = calculateDao.calculate(id);
//			log.info("vo={}", vo);
//			CalculateVO cal = new CalculateVO();
////			cal.builder()
//			.seller_bank_account(vo.get(i).getSeller_bank_account())
//			.seller_bank_code(vo.get(i).getSeller_bank_code())
//			.seller_bank_username(vo.get(i).getSeller_bank_username())
//			.seller_email(vo.get(i).getSeller_email())
//			.seller_id(vo.get(i).getSeller_id())
//			.seller_name(vo.get(i).getSeller_name())
//			.seller_phone(vo.get(i).getSeller_phone())
//			.seller_store_name(vo.get(i).getSeller_store_name())
//			.build();
		
	
//	@Test
//	public void test() {
//		GradeBenefitDto dto = GradeBenefitDto.builder().grade_benefit_grade("브론즈").grade_benefit_rate(1).build();
//		gradeBenefitDao.gradeBenefitRegist(dto);
//	}
	
//	@Test
//	public void test1() {
//		AdminDto adminDto = AdminDto.builder()
//															.admin_id("admin")
//															.admin_pw("admin")
//														.build();
//		AdminDto login = loginDao.login(adminDto);
//		log.info(login.getAdmin_id());
//	}
//	public void test2() {
//
//		PagingVO vo = PagingVO.builder()
//												.start(1)
//												.finish(5)
//											.build();
//		List<SellerDto> list = sellerDao.sellerGetList(vo);
//		log.info("list={}", list.size());
////	}
//	@Test
//	public void test() {
//	
//		 
//		 
//		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss", Locale.KOREA );
//		Date currentTime = new Date ( );
//		String dTime = formatter.format ( currentTime );
//		System.out.println ( dTime );
//	}
}
