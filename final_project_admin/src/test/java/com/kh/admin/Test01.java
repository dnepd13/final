package com.kh.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.entity.GradeBenefitDto;
import com.kh.admin.entity.SellerDto;
import com.kh.admin.repository.AdminDao;
import com.kh.admin.repository.GradeBenefitDao;
import com.kh.admin.repository.SellerDao;
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
	
	@Test
	public void test() {
		GradeBenefitDto dto = GradeBenefitDto.builder().grade_benefit_grade("브론즈").grade_benefit_rate(1).build();
		gradeBenefitDao.gradeBenefitRegist(dto);
	}
	
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
