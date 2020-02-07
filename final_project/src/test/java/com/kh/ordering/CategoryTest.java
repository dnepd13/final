package com.kh.ordering;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ordering.entity.CategoryDto;
import com.kh.ordering.repository.CategoryDao;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class CategoryTest {
	 
	@Autowired
	private CategoryDao categoryDao;
	
//	@Test
//	public void insertTest() {
//		CategoryDto categoryDto = CategoryDto.builder()
//									.category_large("주얼리")
//									.category_middle("귀걸이")
//									.category_small("테스트")
//							.build();
//		categoryDao.insert(categoryDto);
//	}
	
//	@Test
//	public void deleteTest() {
//		categoryDao.delete(19);
//	}
	
//	@Test
//	public void getTest() {
//		log.info("{}", categoryDao.get(1));
//	}
	
	@Test
	public void getListTest() {
		log.info("{}", categoryDao.getList());
	}
}
