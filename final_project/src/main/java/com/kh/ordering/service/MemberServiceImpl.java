package com.kh.ordering.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.GoodsCartDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.entity.OptionCartDto;
import com.kh.ordering.repository.MemberDao;
import com.kh.ordering.repository.Member_PointDao;
import com.kh.ordering.vo.ItemVO;
import com.kh.ordering.vo.ItemVOList;
import com.kh.ordering.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class MemberServiceImpl implements MemberService{

	@Autowired
	private Member_PointDao memberPointDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public CustomOrderDto MemberCustom(HttpSession session, CustomOrderDto customOrderDto,
			MemberCustomOrderDto memberCustomDto) {
		// TODO Auto-generated method stub
		return null;
	}

//	@Override
//	public Member_AddrDto Member_InsertAddr() {
//		 TODO Auto-generated method stub
//		return null;
//	}

	@Override
	public void addCart(String member_id, ItemVOList itemVOList) {
		//DB에 등록! (카테고리)
		List<ItemVO> VOList = itemVOList.getItemVOList();
		List<GoodsCartDto> goodsCartDtoList = new ArrayList<>();
		List<OptionCartDto> optionCartDtoList = new ArrayList<>();
		int member_no = memberDao.getNo(member_id);
		
		for(ItemVO itemVO : VOList) {
			if(itemVO.getOption_no_list() != null) {
				int goods_cart_no = sqlSession.selectOne("goods.getGoodsCartNo");
				GoodsCartDto goodsCartDto = GoodsCartDto.builder()
							.goods_cart_no(goods_cart_no)
							.member_no(member_no) 
							.goods_no(itemVO.getGoods_no())
							.goods_cart_quantity(itemVO.getQuantity())
							.goods_cart_price(itemVO.getPrice())
						.build();
				goodsCartDtoList.add(goodsCartDto);
				List<Integer> noList = itemVO.getOption_no_list();
				for(int option_no : noList) {
					int option_cart_no = sqlSession.selectOne("goods.getOptionCartNo");
					OptionCartDto optionCartDto = OptionCartDto.builder()
								.option_cart_no(option_cart_no)
								.goods_cart_no(goods_cart_no)
								.goods_option_no(option_no)
							.build();
					optionCartDtoList.add(optionCartDto);
				}
			}
		}
		
		memberDao.insertGoodsCartList(goodsCartDtoList);
		memberDao.insertOptionCartList(optionCartDtoList);
	}
	
	@Override
	public void deleteCart(int goods_cart_no) {
		memberDao.deleteCart(goods_cart_no);
	}

// 포인트 내역 페이징
	@Override
	public PagingVO pointInfoPaging(String pageNo, int count) {
		// 주소로 받은 pageNo를 int 형태로 변환
			int pno;
			try {
				pno = Integer.parseInt(pageNo);
				if(pno<=0) throw new Exception();
			}
			catch(Exception e){
				pno = 1;
			}
			
			int pageSize= 10;
			int finish= pno*pageSize;
			int start= finish-(pageSize-1);
				
			// 하단 네비게이터
			int totalCount = count;
			
			int navSize= 5;
			int pageCount= (totalCount+pageSize-1)/pageSize;
				
			int startBlock= (pno-1)/navSize * navSize +1 ;
			int finishBlock= startBlock+(navSize-1);
				
			if(finishBlock>pageCount) {
				finishBlock=pageCount;
			}
			
			PagingVO result = PagingVO.builder()
																	.pno(pno)
																	.navsize(navSize)
																	.count(pageCount)
																	.pagecount(pageCount)
																	.pagesize(pageSize)
																	.startBlock(startBlock)
																	.finishBlock(finishBlock)
																	.start(start)
																	.finish(finish)
																	.build();
				
			return result;
	}
	
	
}
