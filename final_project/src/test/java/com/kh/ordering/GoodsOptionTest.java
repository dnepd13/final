package com.kh.ordering;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ordering.repository.GoodsOptionDao;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class GoodsOptionTest {
	
	@Autowired
	private GoodsOptionDao goodsOptionDao;
	
	@Autowired
	private SqlSession sqlSession;
	
//	 상품 옵션 등록 테스트 [완료]
//	@Test
//	public void insertTest() {
//		List<GoodsOptionDto> list = new ArrayList<>();
//		for(int i=0; i < 10; i++) {
//			GoodsOptionDto goodsOptionDto = GoodsOptionDto.builder()
//					.goods_no(33)
//					.goods_option_title("초록")
//					.goods_option_content("초록입니다.")
//					.goods_option_price(1500)
//					.goods_option_stock(10)
//					.goods_option_status("Y")
//			.build();
//			sqlSession.insert("goods_option.insert", goodsOptionDto);
//		}
//	}
	
//	상품 옵션 삭제 테스트 [완료]
//	@Test
//	public void deleteTest() {
//		goodsOptionDao.delete(1);
//	}
	
//	상품 옵션 단일 조회 테스트 [완료]
//	@Test
//	public void getTest() {
//		log.info("{}", goodsOptionDao.get(2));
//	}
	
//	상품 옵션 전체 조회 테스트 [완료]
//	@Test
//	public void getListTest() {
//		log.info("{}", goodsOptionDao.getList());
//	}
	
//	옵션 이름 별 목록 불러오기 [완료]
	@Test
	public void getGoodsOptionListTest() {
		log.info("{}", goodsOptionDao.getGoodsOptionVOList(21));
	}
	
}
