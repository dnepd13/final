package com.kh.ordering;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;

import lombok.extern.slf4j.Slf4j;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class MemberCustomTest {
	
	@Autowired
	private SqlSession sqlSession;

	@Test
	public void customInsert() {
		// 회원 id로 회원
		String member_id = "member";
		int member_no = sqlSession.selectOne("member.getNo", member_id);
		
		// 요청서 등록 -> 테스트 완료
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
		
		// 요청서 관리테이블 등록
		MemberCustomOrderDto memberCustom = MemberCustomOrderDto.builder()
																													.member_custom_order_no(1)
																													.custom_order_no(customOrderDto.getCustom_order_no())
																													.member_no(member_no)
																													.build();
		sqlSession.insert("member.memberCustom", memberCustom);
	}
}
