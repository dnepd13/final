package com.kh.ordering;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.repository.GoodsDao;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class GoodsTest {
	
	@Autowired
	private GoodsDao goodsDao;
	
//  상품 등록 테스트 [완료]
//	@Test
//	public void insertTest() {
//		GoodsDto goodsDto = GoodsDto.builder()
//								.seller_no(2)
//								.goods_name("골드반지")
//								.goods_price(1500000)
//								.goods_stock(10)
//								.goods_discount_price(0)
//								.goods_discount_start("20/02/05")
//								.goods_discount_finish("21/02/05")
//								.goods_status("Y")
//								.goods_content("골드 반지입니다.")
//							.build();
//		goodsDao.insert(goodsDto);
//	}
	
//	상품 삭제 테스트 [완료]
//	@Test
//	public void deleteTest() {
//		goodsDao.delete(1);
//	}
	
//	상품 단일 조회 테스트 [완료]
//	@Test
//	public void getTest() {
//		log.info("{}",goodsDao.get(2));
//	}
	
//	상품 전체 조회 테스트 [완료]
//	@Test
//	public void getListTest() {
//		log.info("{}", goodsDao.getList());
//	}
}
