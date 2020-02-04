package com.kh.ordering;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ordering.entity.Dto;

import lombok.extern.slf4j.Slf4j;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class test01 {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
		Dto dto = Dto.builder()
								.admin_no(1)
								.admin_id("admin")
								.admin_pw("admin")
								.admin_name("관리자")
								.admin_email("admin@admin.com")
								.admin_grade("관리자")
				.build();
		
		sqlSession.insert("memo.insert", dto);
	}
}
