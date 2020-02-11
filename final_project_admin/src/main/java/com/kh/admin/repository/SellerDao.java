package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.SellerDto;
import com.kh.admin.vo.PagingVO;

public interface SellerDao {
	public int sellerCount();
	public List<SellerDto> sellerGetList(PagingVO vo);
	public SellerDto sellerGetOne(SellerDto sellerDto);
	public void sellerDelete(SellerDto sellerDto);
}
