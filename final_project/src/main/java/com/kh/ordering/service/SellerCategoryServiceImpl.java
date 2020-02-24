//package com.kh.ordering.service;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.kh.ordering.repository.SellerCategoryDao;
//
//@Service
//
//public class SellerCategoryServiceImpl  implements SellerCategoryService{
//@Autowired
//private SellerCategoryDao sellerCategoryDao;
//	//카테고리 목록 페이징--------------------------------------------------------
//	@Override
//	public SellerCategoryPagingVO categoryPagination(String pno1) {
//		int pno; 
//		try{ 
//			pno = Integer.parseInt(pno1);
//			if(pno <= 0) throw new Exception();
//		}
//		catch(Exception e){
//			pno = 1;
//			
//		}
//		int pagesize = 5;
//		int finish = pno * pagesize;
//		int start = finish - (pagesize-1);
//			
//			int count = sellerCategoryDao.categoryCount();
//			int navsize = 10;
//			int pagecount = (count+pagesize-1) / pagesize;
//			
//			int startBlock = (pno - 1) / navsize * navsize + 1;
//			int finishBlock = startBlock + (navsize - 1);
//			
//			if(finishBlock>pagecount){
//				finishBlock = pagecount;
//			}
//
//			SellerCategoryPagingVO vo = SellerCategoryPagingVO.builder()
//												.pno(pno)
//												.navsize(navsize)
//												.count(count)
//												.pagecount(pagecount)
//												.pagesize(pagesize)
//												.startBlock(startBlock)
//												.finishBlock(finishBlock)
//												.start(start)
//												.finish(finish)
//											.build();
//		
//		return vo;
//	}
//	
//}
