package com.kh.ordering.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.GoodsDao;
import com.kh.ordering.repository.GoodsOptionDao;
import com.kh.ordering.repository.GoodsQnaDao;
import com.kh.ordering.vo.GoodsFileVO;
import com.kh.ordering.vo.GoodsOptionVO;
import com.kh.ordering.vo.GoodsVO;
import com.kh.ordering.vo.PagingVO;

public class GoodsService {

	@Autowired
	private FilesDao filesDao;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private GoodsOptionDao goodsOptionDao;
	
	@Autowired
	private GoodsQnaDao goodsQnaDao;
	
	
	public int insert(GoodsVO goodsVO) {
		goodsDao.insert(goodsVO);
		return goodsDao.getSequence();
	}
	
	public void delete(int goods_no) {
		goodsDao.delete(goods_no);
	}
	
	public GoodsDto get(int goods_no) {
		return goodsDao.get(goods_no);
	}
	
	public List<GoodsDto> getList() {
		return goodsDao.getList();
	}

	public GoodsVO getGoodsVO(int goods_no) {
		return goodsDao.getGoodsVO(goods_no);
	}

	public List<GoodsOptionVO> getGoodsOptionVOList(int goods_no) {
		return goodsOptionDao.getGoodsOptionVOList(goods_no);
	}
	
	public int insertFiles(MultipartFile multipartFile, int goods_no) {
		return filesDao.insertGoodsFiles(multipartFile, goods_no);
	}
	
	// 다중 파일(content_image)
	public List<Integer> insertFiles(MultipartFile[] multipartFileList, int goods_no) {
		return filesDao.insertGoodsFiles(multipartFileList, goods_no);
	}
	
	
	// 문의 게시판 내비게이터
	public PagingVO goodsQnaPaging(String pageNo, int goods_no) {
		int pno;
		try {
			pno=Integer.parseInt(pageNo);
			if(pno<=0) throw new Exception();
		}
		catch(Exception e){
			pno=1;
		}
		
		int pageSize=10;
		int finish= pno*pageSize;
		int start= finish-(pageSize-1);
		
		// 하단 내비
		int totalCount = goodsQnaDao.goodsQnaCount(goods_no);
		int navSize= 10;
		int pageCount= (totalCount+pageSize-1)/pageSize;
		
		int startBlock=(pno-1)/navSize * navSize +1;
		int finishBlock= startBlock + (navSize-1);
		
		if(finishBlock>pageCount) {
			finishBlock=pageCount;
		}
		
//		int seller_no= goodsQnaDao.getSeller(goods_no);
		
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
//				.seller_no(seller_no)
				.goods_no(goods_no)
				.build();
		return pagingVO;
	}
	
	public List<GoodsFileVO> getListBest(){
		return goodsDao.getListBest();
	}
	
	public List<GoodsFileVO> getListNew() {
		return goodsDao.getListNew();
	}

	public List<GoodsDto> search(String keyword) {
		return goodsDao.search(keyword);
	}
	
	// 정렬 나중에..
//	public void align(String type) {
//		goodsDao.getList(type);
//	}
}
