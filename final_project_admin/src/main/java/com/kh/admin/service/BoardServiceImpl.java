package com.kh.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.admin.repository.AdminDao;
import com.kh.admin.repository.AdminManageDao;
import com.kh.admin.repository.BoardDao;
import com.kh.admin.repository.CategoryDao;
import com.kh.admin.repository.GoodsDao;
import com.kh.admin.repository.MemberDao;
import com.kh.admin.repository.SellerDao;
import com.kh.admin.vo.MemberPointVO;
import com.kh.admin.vo.PagingVO;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private AdminManageDao adminManage;
	
	@Autowired
	private SellerDao sellerDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private GoodsDao goodsDao;
	
	
	//관리자 목록 페이징--------------------------------------------------------
	@Override
	public PagingVO pagination(String pno1) {
		int pno; 
		try{ 
			pno = Integer.parseInt(pno1);
			if(pno <= 0) throw new Exception();
		}
		catch(Exception e){
			pno = 1;
			
		}
		int pagesize = 10;
		int finish = pno * pagesize;
		int start = finish - (pagesize-1);
		//#####################################################################################
		//하단 네이게이터 계산하기
//			시작블록 = (전체페이지 -1 ) / 네이게이터 크기 * 네이게이터 크기 +1
		//#####################################################################################
			
			int count = adminManage.countBoard();
			int navsize = 10;
			int pagecount = (count+pagesize-1) / pagesize;
			
			int startBlock = (pno - 1) / navsize * navsize + 1;
			int finishBlock = startBlock + (navsize - 1);
			
//		 	만약 마지막 블록이 페이지수보다 크다면 수정 처리
			if(finishBlock>pagecount){
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


	//카테고리 목록 페이징--------------------------------------------------------
	@Override
	public PagingVO categoryPagination(String pno1) {
		int pno; 
		try{ 
			pno = Integer.parseInt(pno1);
			if(pno <= 0) throw new Exception();
		}
		catch(Exception e){
			pno = 1;
			
		}
		int pagesize = 5;
		int finish = pno * pagesize;
		int start = finish - (pagesize-1);
			
			int count = categoryDao.categoryCount();
			int navsize = 10;
			int pagecount = (count+pagesize-1) / pagesize;
			
			int startBlock = (pno - 1) / navsize * navsize + 1;
			int finishBlock = startBlock + (navsize - 1);
			
			if(finishBlock>pagecount){
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
	public PagingVO adminQnaPagination(String pno1) {
		int pno; 
		try{ 
			pno = Integer.parseInt(pno1);
			if(pno <= 0) throw new Exception();
		}
		catch(Exception e){
			pno = 1;
			
		}
		int pagesize = 10;
		int finish = pno * pagesize;
		int start = finish - (pagesize-1);
			
			int count = boardDao.adminQnaCount();
			int navsize = 10;
			int pagecount = (count+pagesize-1) / pagesize;
			
			int startBlock = (pno - 1) / navsize * navsize + 1;
			int finishBlock = startBlock + (navsize - 1);
			
			if(finishBlock>pagecount){
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
		public PagingVO pointPagination(String pno1, int member_no) {
		int pno; 
		try{ 
			pno = Integer.parseInt(pno1);
			if(pno <= 0) throw new Exception();
		}
		catch(Exception e){
			pno = 1;
			
		}
		int pagesize = 10;
		int finish = pno * pagesize;
		int start = finish - (pagesize-1);
			
			MemberPointVO memberPointVO = MemberPointVO.builder().member_no(member_no).build();
		
			int count = memberDao.pointCount(memberPointVO);
			int navsize = 10;
			int pagecount = (count+pagesize-1) / pagesize;
			
			int startBlock = (pno - 1) / navsize * navsize + 1;
			int finishBlock = startBlock + (navsize - 1);
			
			if(finishBlock>pagecount){
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

	//차단 회원 페이징
	@Override
	public PagingVO blockPagination(String pno1) {
		int pno; 
		try{ 
			pno = Integer.parseInt(pno1);
			if(pno <= 0) throw new Exception();
		}
		catch(Exception e){
			pno = 1;
			
		}
		int pagesize = 5;
		int finish = pno * pagesize;
		int start = finish - (pagesize-1);
			
			int count = adminDao.blockCount();
			int navsize = 10;
			int pagecount = (count+pagesize-1) / pagesize;
			
			int startBlock = (pno - 1) / navsize * navsize + 1;
			int finishBlock = startBlock + (navsize - 1);
			
			if(finishBlock>pagecount){
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
	public PagingVO allPaging(String pno1, int getCount) {
		int pno; 
		try{ 
			pno = Integer.parseInt(pno1);
			if(pno <= 0) throw new Exception();
		}
		catch(Exception e){
			pno = 1;
			
		}
		int pagesize = 10;
		int finish = pno * pagesize;
		int start = finish - (pagesize-1);
			
			int count = getCount;
			int navsize = 10;
			int pagecount = (count+pagesize-1) / pagesize;
			
			int startBlock = (pno - 1) / navsize * navsize + 1;
			int finishBlock = startBlock + (navsize - 1);
			
			if(finishBlock>pagecount){
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

}
