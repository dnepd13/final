package com.kh.ordering;

import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.repository.SellerCustomDao;

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
		
		// 요청서 시퀀스번호 가져오기
		int custom_order_no = sqlSession.selectOne("member.customSeq");
		
		// 요청서 관리테이블 등록
		MemberCustomOrderDto memberCustom = MemberCustomOrderDto.builder()
																													.member_custom_order_no(1)
																													.custom_order_no(custom_order_no)
																													.member_no(member_no)
																													.build();
		sqlSession.insert("member.customInsert", memberCustom);	
		
		// 파일이 있다면 파일 테이블에 파일 등록하고
		// 주문제작-파일 중개테이블에 파일 번호, 저장테이블 시퀀스 등록

/*			
		// 판매자 요청서 도착 알람 생성
		SellerCustomAlarmDto sellerCustomAlarmDto = SellerCustomAlarmDto.builder()
																						.seller_alarm_no(1) //테이블 고유번호
																						.seller_no(2) //판매자 번호
																						.member_custom_order_no(1)	 //요청서 번호
																						.seller_alarm_date("20200206") //알람 확인날짜
																						.seller_alarm_check("N") //알람확인여부
																						.seller_alarm_delete("N") //알람삭제
																						.build();
		sqlSession.insert("seller.insertAlarm", sellerCustomAlarmDto);
*/
	}
	@Autowired
	private SellerCustomDao sellerCustomDao;
	
	@Test
	public void fileTest() throws IOException {
//		memberCustomDao.getCustomFile()
	}
}
