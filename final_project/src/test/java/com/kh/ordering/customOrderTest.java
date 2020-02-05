package com.kh.ordering;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ordering.entity.CustomOrderDto;

import lombok.extern.slf4j.Slf4j;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class customOrderTest {
	
	@Autowired
	private SqlSession sqlSession;
/*	
	@Test
	public void test() {
		TestDto dto = TestDto.builder()
								.admin_no(1)
								.admin_id("admin")
								.admin_pw("admin")
								.admin_name("관리자")
								.admin_email("admin@admin.com")
								.admin_grade("관리자")
				.build();
		
		sqlSession.insert("memo.insert", dto);
	}
*/

	@Test
	public void customInsert() {
		CustomOrderDto customOrderDto = CustomOrderDto.builder()
																							.custom_order_no(1)
																							.custom_order_title("제목")
																							.custom_order_content("내용")
																							.custom_order_date("20200205")
																							.custom_order_price(10000)
																							.custom_order_hopedate("내이띾지")
																							.custom_order_status("진행중")
																							.custom_order_type("요청서")
																							.build();
		
		sqlSession.insert("member.customReq", customOrderDto);
	}
}
