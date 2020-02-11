package com.kh.ordering.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.entity.SellerAlarmDto;
import com.kh.ordering.repository.MemberDao;

public class MemberServiceImpl implements MemberService{

	
	@Override
	public CustomOrderDto MemberCustom(HttpSession session, CustomOrderDto customOrderDto,
			MemberCustomOrderDto memberCustomDto, SellerAlarmDto sellerAlarmDto) {
		// TODO Auto-generated method stub
		return null;
	}

//	@Override
//	public Member_AddrDto Member_InsertAddr() {
//		 TODO Auto-generated method stub
//		return null;
//	}

}
