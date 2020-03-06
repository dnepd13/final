package com.kh.ordering;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.vo.GoodsStockVO;
import com.kh.ordering.vo.GoodsVO;

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
//								.goods_name("다이아반지")
//								.goods_price(1500000)
//								.goods_stock(10)
//								.goods_discount_price(0)
//								.goods_discount_start("20/02/05")
//								.goods_discount_finish("21/02/05")
//								.goods_status("Y")
//								.goods_content("다이아 반지입니다.")
//								.category_no(1)
//							.build();
//		goodsDao.insert(goodsDto);
//	}
	
//	상품 삭제 테스트 [완료]
//	@Test
//	public void deleteTest() {
//		goodsDao.delete(15);
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
	
//	VO 조회 테스트
//	@Test
//	public void getGoodsVOTest() {
//		log.info("{}", goodsDao.getGoodsVO(21));
//		log.info("{}", goodsDao.getGoodsVO(21).getGoodsOptionList());
//	}
//	
//	VO 입력 테스트
//	@Test
//	public void insertGoodsVOTest() {
//		List<GoodsOptionDto> list = new ArrayList<>();
//		
//		GoodsOptionDto goodsOptionDto = GoodsOptionDto.builder()
//											.goods_no(41)
//											.goods_option_title("운기마크1")
//											.goods_option_content("운기마크1입니다")
//											.goods_option_price(1000)
//											.goods_option_stock(10)
//											.goods_option_status("Y")
//										.build();
//		
//		GoodsOptionDto goodsOptionDto2 = GoodsOptionDto.builder()
//											.goods_no(41)
//											.goods_option_title("운기마크2")
//											.goods_option_content("운기마크2입니다")
//											.goods_option_price(2000)
//											.goods_option_stock(20)
//											.goods_option_status("Y")
//										.build();
//		
//		
//		list.add(goodsOptionDto);
//		list.add(goodsOptionDto2);
//		
//		GoodsVO goodsVO = GoodsVO.builder()
//							.seller_no(2)
//							.goods_name("운기가 제작한 은반지")
//							.goods_price(12000)
//							.goods_stock(10)
//							.goods_discount_price(0)
//							.goods_discount_start("20/02/05")
//							.goods_discount_finish("21/02/05")
//							.goods_status("Y")
//							.goods_content("운기가 제작한 은반지입니다.")
//							.category_no(5)
//							.goodsOptionList(list)
//						.build();
//		
//		goodsDao.insert(goodsVO);
//	}
	
	// 수량 감소 테스트
//	@Test
//	public void minusStockTest() {
//		goodsDao.minusStock(21, 1);
//	}
	
	// 수량 증가 테스트
//	@Test
//	public void plusStockTest() {
//		goodsDao.plusStock(21, 10);
//	}
	
	// 판매자 상품 목록 불러오기
//	@Test
//	public void getGoodsVOListTest() {
//		log.info("{}", goodsDao.getGoodsVOList(287));
//	}
	
	// 컨텐트 이미지 테스트
	@Test
	public void getContentImageTest() {
		log.info("#############{}",goodsDao.getContentImage(205));
		
	}
	
}
