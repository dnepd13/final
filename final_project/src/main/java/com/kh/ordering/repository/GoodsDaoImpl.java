package com.kh.ordering.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.GoodsDto;
import com.kh.ordering.entity.GoodsOptionDto;
import com.kh.ordering.vo.GoodsStockVO;
import com.kh.ordering.vo.GoodsVO;

public class GoodsDaoImpl implements GoodsDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Override
	public void insert(GoodsVO goodsVO) {
		GoodsDto goodsDto = GoodsDto.builder()
								.seller_no(goodsVO.getSeller_no())
								.goods_name(goodsVO.getGoods_name())
								.goods_price(goodsVO.getGoods_price())
								.goods_discount_price(goodsVO.getGoods_discount_price())
								.goods_discount_start(goodsVO.getGoods_discount_start())
								.goods_discount_finish(goodsVO.getGoods_discount_finish())
								.goods_stock(goodsVO.getGoods_stock())
								.goods_status(goodsVO.getGoods_status())
								.goods_content(goodsVO.getGoods_content())
								.category_no(goodsVO.getCategory_no())
							.build();
		sqlSession.insert("goods.insert", goodsDto);
		goodsDto.setGoods_no(sqlSession.selectOne("goods.getSequence"));
		
		if(goodsVO.getGoodsOptionList() != null) {
			for(GoodsOptionDto dto : goodsVO.getGoodsOptionList()) {
				dto.setGoods_no(goodsDto.getGoods_no());
			}
			sqlSession.insert("goods_option.insertAll", goodsVO.getGoodsOptionList());
		}
	}
	
	
	
	@Override
	public void plusStock(int goods_no, int stock) {
		GoodsStockVO goodsStockVO = GoodsStockVO.builder()
				.goods_no(goods_no)
				.stock(stock)
				.build();
		sqlSession.update("goods.plusStock", goodsStockVO);
	}
	
	@Override
	public boolean minusStock(int goods_no, int stock) {
		if(goodsDao.getStock(goods_no)>=stock) {
			GoodsStockVO goodsStockVO = GoodsStockVO.builder()
					.goods_no(goods_no)
					.stock(stock)
					.build();
			sqlSession.update("goods.minusStock", goodsStockVO);
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public int getStock(int goods_no) {
		return sqlSession.selectOne("goods.getStock", goods_no);
	}
	
	@Override
	public void delete(int goods_no) {
		sqlSession.delete("goods.delete", goods_no);
	}
	
	@Override
	public GoodsDto get(int goods_no) {
		return sqlSession.selectOne("goods.get", goods_no);
	}
	
	@Override
	public List<GoodsDto> getList() {
		return sqlSession.selectList("goods.getList");
	}
	
	@Override
	public int getSequence() {
		return sqlSession.selectOne("goods.getSequence");
	}
	
	// 상품 정보 + 상품에 딸린 옵션들 불러오기
	@Override
	public GoodsVO getGoodsVO(int goods_no) {
		return sqlSession.selectOne("goods.getGoodsVO", goods_no);
	}
	
	@Override
	public List<Integer> getGoodsNoList(int seller_no) {
		return sqlSession.selectList("goods.getGoodsNoList", seller_no);
	}
	
	// 판매자 상품 조회
	@Override
	public List<GoodsVO> getGoodsVOList(int seller_no){
		List<Integer> goodsNoList = this.getGoodsNoList(seller_no);
		List<GoodsVO> goodsVOList = new ArrayList<>();
		for (Integer goods_no : goodsNoList) {
			goodsVOList.add(this.getGoodsVO(goods_no));
		}
		return goodsVOList;
	}
	
}
