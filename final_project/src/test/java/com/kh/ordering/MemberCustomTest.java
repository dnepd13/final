package com.kh.ordering;

import java.net.URI;
import java.net.URISyntaxException;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.vo.KakaoPayReadyReturnVO;

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

/*			
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
	}
 */
/*
	@Autowired
	private MemberCustomDao memberCustomDao;
	
	@Test
	public void deleteTest() throws IOException {
		int member_custom_order_no = 9;
		
		memberCustomDao.deleteAlarm(member_custom_order_no);
		memberCustomDao.deleteCustom(member_custom_order_no);
	}
*/
	@Autowired
	MemberDao memberDao;
	
	@Test
	public void readyRequest() throws URISyntaxException {
		
		// 회원정보
		String member_id="member";
		 int member_no = memberDao.getNo(member_id);
		 String member = String.valueOf(member_no);
		
		 int customNo = 25;
		 
		// 헤더
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK 53072513ab4d31c036edec9ad0220095");
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE); // 카카오의 응답을 받을 형태
		 
		// 바디
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("cid", "TC0ONETIME");
		body.add("partner_order_id", "C"+customNo); // 견적서 번호
		body.add("partner_user_id", member_id);
		body.add("item_name", "주문제작 제목");
		body.add("quantity", "1");
		body.add("total_amount", "200000"); // 견적가격
		body.add("tax_free_amount", "0");
		body.add("vat_amount", "0");
		body.add("approval_url", "http://localhost:8080/ordering/member/cartList");
		body.add("cancel_url", "http://localhost:8080/ordering/member/customListResp");
		body.add("fail_url", "http://localhost:8080/ordering/member/customInfoResp");
		
		body.add("member", member);
		
		HttpEntity<MultiValueMap<String, String>> entity
																= new HttpEntity<>(body, headers);
		
		// 도구 = 헤더+바디
		RestTemplate template = new RestTemplate();
		
		// 요청주소
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		// 요청주소에 전송 및 회신 응답 저장
		//										 url, 요청객체, 응답객체(JSON)
		KakaoPayReadyReturnVO readyReturnVO =
								template.postForObject(uri, entity, KakaoPayReadyReturnVO.class);

	}
}
