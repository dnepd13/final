package com.kh.ordering.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

import com.kh.ordering.entity.AdminQnaDto;
import com.kh.ordering.repository.AdminQnaDao;


//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations= {
//		"file:src/main/webapp/WEB-INF/spring/root-contex.xml",
//		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context"
//})
//@WebAppConfiguration
@Service
@Slf4j
public class BoardQnaServiceImpl implements BoardQnaService{

	@Autowired
	private AdminQnaDao adminQnaDao;

//	설정해야할 필수 값은 다음과 같디.
//	
//	1. 페이지 크기 '10'
//	2. 네비게이터 크기 '10'
//	
//	계산해야할 항목은 다음과 같다.
//	1.지금 현재 페이지에서 표시해야할 게시글의 번호 (순서) -TOP N

//		select * from(
//		select rownum rn, A.*from(
//		select * from board order by no desc 
//		(이부분만 변경하면 어떤 데이터든 원하는 구분을 뽑아서 보여줄수 있다)	
//		)A;
//	위 구문을 실행시키면 rn 번호가 붙어서 나온다
//	)where rn between ? and ?;
//				  게시글의 (1)번부터 (5000)번까지 구해온다	


	//	2.지금 현재 페이지에서 표시해야할 네비게이터의 번호


	@Override
	public PagingVO adminQnaPagination(String pno1, int member_no) {

		int pno; //no 선언
		try {
			pno = Integer.parseInt(pno1); //선언된 pno를 인티저의 int타입으로 넣음
			if(pno <= 0) throw new Exception(); //만약 pno가 0이라면 이셉션처리
		}
		catch(Exception e) {

			pno = 1; //그외 예외처리시 pno는 1로 가정
		}
		int pagesize = 10; // 네비게이터 크기는 10으로
		int finish = pno * pagesize; //네비게이터의끝
		int start = finish - (pagesize-1); //네비게이터의 시작

		/*하단 네비게이터 계산
		 	시작블록= (전체페이지 -1) / 네비게이터 크기 * 네비게이터 크기+1
		 */

		int count = adminQnaDao.countBoard(member_no);
		int navsize = 10;
		int pagecount = (count+pagesize-1) / pagesize;


		int startBlock = (pno - 1) / navsize * navsize +1;
		int finishBlock = startBlock + (navsize - 1);

		//만약 마지막 블록이 페이지 수보다 크다면 수정하여 처리할것
		if(finishBlock > pagecount) {
			finishBlock = pagecount;
		}

		PagingVO vo = PagingVO.builder()
				.pno(pno)
				.navsize(navsize)
				.count(count)
				.pagecount(pagecount)
				.pagesize(pagesize)
				.startBlock(startBlock)
				.finishBlock(finishBlock)
				.start(start)
				.finish(finish)
				.member_no(member_no)
			.build();

		return vo;
	}

	@Override
	public PagingVO QnaPagination(String pno1, int member_no) {
		int pno; //no 선언
		try {
			pno = Integer.parseInt(pno1); //선언된 pno를 인티저의 int타입으로 넣음
			if(pno <= 0) throw new Exception(); //만약 pno가 0이라면 이셉션처리
		}
		catch(Exception e) {

			pno = 1; //그외 예외처리시 pno는 1로 가정
		}
		int pagesize = 10; // 네비게이터 크기는 10으로
		int finish = pno * pagesize; //네비게이터의끝
		int start = finish - (pagesize-1); //네비게이터의 시작

		/*하단 네비게이터 계산
		 	시작블록= (전체페이지 -1) / 네비게이터 크기 * 네비게이터 크기+1
		 */

		int count = adminQnaDao.countqna(member_no);
		int navsize = 10;
		int pagecount = (count+pagesize-1) / pagesize;


		int startBlock = (pno - 1) / navsize * navsize +1;
		int finishBlock = startBlock + (navsize - 1);

		//만약 마지막 블록이 페이지 수보다 크다면 수정하여 처리할것
		if(finishBlock > pagecount) {
			finishBlock = pagecount;
		}

		PagingVO vo = PagingVO.builder()
				.pno(pno)
				.navsize(navsize)
				.count(count)
				.pagecount(pagecount)
				.pagesize(pagesize)
				.startBlock(startBlock)
				.finishBlock(finishBlock)
				.start(start)
				.finish(finish)
			.build();

		return vo;
	}

	@Override
	public PagingVO QnaPagination1(String pno2, int seller_no) {
		int pno; //no 선언
		try {
			pno = Integer.parseInt(pno2); //선언된 pno를 인티저의 int타입으로 넣음
			if(pno <= 0) throw new Exception(); //만약 pno가 0이라면 이셉션처리
		}
		catch(Exception e) {

			pno = 1; //그외 예외처리시 pno는 1로 가정
		}
		int pagesize = 10; // 네비게이터 크기는 10으로
		int finish = pno * pagesize; //네비게이터의끝
		int start = finish - (pagesize-1); //네비게이터의 시작

		/*하단 네비게이터 계산
		 	시작블록= (전체페이지 -1) / 네비게이터 크기 * 네비게이터 크기+1
		 */

		int count = adminQnaDao.countsellerqna(seller_no);
		int navsize = 10;
		int pagecount = (count+pagesize-1) / pagesize;


		int startBlock = (pno - 1) / navsize * navsize +1;
		int finishBlock = startBlock + (navsize - 1);

		//만약 마지막 블록이 페이지 수보다 크다면 수정하여 처리할것
		if(finishBlock > pagecount) {
			finishBlock = pagecount;
		}

		PagingVO vo = PagingVO.builder()
				.pno(pno)
				.navsize(navsize)
				.count(count)
				.pagecount(pagecount)
				.pagesize(pagesize)
				.startBlock(startBlock)
				.finishBlock(finishBlock)
				.start(start)
				.finish(finish)
			.build();

		return vo;
	}

	@Override
	public PagingVO adminQnaPagination1(String pno2, int seller_no) {

		int pno; //no 선언
		try {
			pno = Integer.parseInt(pno2); //선언된 pno를 인티저의 int타입으로 넣음
			if(pno <= 0) throw new Exception(); //만약 pno가 0이라면 이셉션처리
		}
		catch(Exception e) {

			pno = 1; //그외 예외처리시 pno는 1로 가정
		}
		int pagesize = 10; // 네비게이터 크기는 10으로
		int finish = pno * pagesize; //네비게이터의끝
		int start = finish - (pagesize-1); //네비게이터의 시작

		/*하단 네비게이터 계산
		 	시작블록= (전체페이지 -1) / 네비게이터 크기 * 네비게이터 크기+1
		 */

		int count = adminQnaDao.countSellerBoard(seller_no);
		int navsize = 10;
		int pagecount = (count+pagesize-1) / pagesize;


		int startBlock = (pno - 1) / navsize * navsize +1;
		int finishBlock = startBlock + (navsize - 1);

		//만약 마지막 블록이 페이지 수보다 크다면 수정하여 처리할것
		if(finishBlock > pagecount) {
			finishBlock = pagecount;
		}

		PagingVO vo = PagingVO.builder()
				.pno(pno)
				.navsize(navsize)
				.count(count)
				.pagecount(pagecount)
				.pagesize(pagesize)
				.startBlock(startBlock)
				.finishBlock(finishBlock)
				.start(start)
				.finish(finish)
				.seller_no(seller_no)
			.build();

		return vo;
	}

///// 회원 마이페이지 메인 문의내용 페이징
	@Override
	public PagingVO myInfoQnaPaging(String paging, int member_no) {

		int pno; //no 선언
		try {
			pno = Integer.parseInt(paging); //선언된 pno를 인티저의 int타입으로 넣음
			if(pno <= 0) throw new Exception(); //만약 pno가 0이라면 이셉션처리
		}
		catch(Exception e) {

			pno = 1; //그외 예외처리시 pno는 1로 가정
		}
		int pagesize = 4; // 네비게이터 크기는 10으로
		int finish = pno * pagesize; //네비게이터의끝
		int start = finish - (pagesize-1); //네비게이터의 시작

		/*하단 네비게이터 계산
		 	시작블록= (전체페이지 -1) / 네비게이터 크기 * 네비게이터 크기+1
		 */

		int count = adminQnaDao.getYesterDayCount(member_no);
		int navsize = 10;
		int pagecount = (count+pagesize-1) / pagesize;


		int startBlock = (pno - 1) / navsize * navsize +1;
		int finishBlock = startBlock + (navsize - 1);

		//만약 마지막 블록이 페이지 수보다 크다면 수정하여 처리할것
		if(finishBlock > pagecount) {
			finishBlock = pagecount;
		}

		PagingVO pagingVO = PagingVO.builder()
				.pno(pno)
				.navsize(navsize)
				.count(count)
				.pagecount(pagecount)
				.pagesize(pagesize)
				.startBlock(startBlock)
				.finishBlock(finishBlock)
				.start(start)
				.finish(finish)
				.member_no(member_no)
			.build();

		return pagingVO;
	}
	
}
