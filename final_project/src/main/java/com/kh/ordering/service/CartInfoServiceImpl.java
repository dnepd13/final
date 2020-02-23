package com.kh.ordering.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.repository.OrderDao;
import com.kh.ordering.vo.PagingVO;

public class CartInfoServiceImpl implements CartInfoService {

	@Autowired
	private OrderDao orderDao;
	
//	회원 주문내역 페이징
	@Override
	public PagingVO cartInfoPaging(String pageNo, int member_no) {
		// 주소로 받은 pageNo를 int 형태로 변환
		int pno;
		try {
			pno = Integer.parseInt(pageNo);
			if(pno<=0) throw new Exception();
		}
		catch(Exception e){
			pno = 1;
		}
		
		int pageSize= 5;
		int finish= pno*pageSize;
		int start= finish-(pageSize-1);
		
		// 하단 네비게이터
		int totalCount = orderDao.getCartInfoCount(member_no);
		int navSize= 10;
		int pageCount= (totalCount+pageSize-1)/pageSize;
		
		int startBlock= (pno-1)/navSize * navSize +1 ;
		int finishBlock= startBlock+(navSize-1);
		
		if(finishBlock>pageCount) {
			finishBlock=pageCount;
		}
		
		PagingVO pagingVO = PagingVO.builder()
																.pno(pno)
																.navsize(navSize)
																.count(pageCount)
																.pagecount(pageCount)
																.pagesize(pageSize)
																.startBlock(startBlock)
																.finishBlock(finishBlock)
																.start(start)
																.finish(finish)
																.member_no(member_no)
																.build();
		
		return pagingVO;
	}
}
