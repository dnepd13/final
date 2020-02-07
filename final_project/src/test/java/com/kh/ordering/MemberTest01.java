package com.kh.ordering;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ordering.entity.MemberDto;

import lombok.extern.slf4j.Slf4j;

//Spring 기존 환경을 테스트에 연동하고 싶은 경우 사용



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {



	"file:src/main/webapp/WEB-INF/spring/root-context.xml",



	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"



})



@WebAppConfiguration



@Slf4j
public class MemberTest01 {

	@Autowired
	private SqlSession sqlSession;







	@Test
	public void test() {



		MemberDto memberDto = MemberDto.builder()
				.member_name("홍길동")
				.member_birth("20000101")
				.member_phone("01012113434")
				.member_id("cda12")
				.member_pw("cda12")
				.member_email("cd12a@test.com")
				.build();



		sqlSession.insert("member.regist", memberDto);



}
				
}
