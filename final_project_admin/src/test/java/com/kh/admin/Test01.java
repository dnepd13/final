package com.kh.admin;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.repository.LoginDao;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class Test01 {

	@Autowired
	LoginDao loginDao;
	
	@Test
	public void test1() {
		AdminDto adminDto = AdminDto.builder()
															.admin_id("admin")
															.admin_pw("admin")
														.build();
		AdminDto login = loginDao.login(adminDto);
		log.info(login.getAdmin_id());
	}
}
