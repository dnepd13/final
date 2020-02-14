package com.kh.ordering;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ordering.repository.DeliveryDao;
import com.kh.ordering.vo.DeliveryVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class DeliveryTest {
	
	@Autowired
	private DeliveryDao deliveryDao;
	
//	@Test
//	public void insertTest() {
//		DeliveryVO deliveryVO = DeliveryVO.builder()
//							.delivery_agree("Y")
//							.delivery_set_agree("Y")
//							.delivery_company("로젠")
//							.delivery_price(1500)
//							.delivery_option("조건부무료")
//							.delivery_set_op_price(30000)
//							.delivery_return_price(1500)
//							.delivery_op_price(0)
//							.goods_no(61)
//							.seller_no(93)
//						.build();
//		deliveryDao.insert(deliveryVO);
//	}
	
//	@Test
//	public void deleteTest() {
//		deliveryDao.delete(1);
//	}
	
	@Test
	public void getTest() {
		log.info("{}",deliveryDao.get(2));
	}
	
//	@Test
//	public void getListTest() {
//		log.info("{}", deliveryDao.getList());
//	}
}
