package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.vo.GoodsCategoryVO;
import com.kh.admin.vo.GoodsVO;
import com.kh.admin.vo.PagingVO;
import com.kh.admin.vo.SellerGoodsVO;

public interface GoodsDao {
	public GoodsVO getGoodsVO(int goods_no);
	public List<GoodsCategoryVO> listGoods(PagingVO vo);
	public int goodsCount();
	public void goodsDelete(GoodsVO goodsVO);
	public int goodsNameCount(String goods_name);
	public int goodsIdCount(String seller_id);
}
