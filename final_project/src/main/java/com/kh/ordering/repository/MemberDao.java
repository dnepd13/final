package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.GoodsCartDto;
import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.entity.OptionCartDto;
import com.kh.ordering.vo.MemberPointVO;

public interface MemberDao {

//	포인트 관련  //////////////////////////

	int getPoint(int member_no);
	int getPoint(String member_id);
	public void memberedit(MemberDto member);
	public MemberDto memberGetOne(int member_no);
	//판매자 아이디 중복검사
	int id_check(String member_id);
	//회원 아이디 찾기
	MemberDto memberfind_id(MemberDto memberDto);
	public void memberchange_pw(MemberDto memberDto);
	void registPoint(MemberPointVO memberPointVO);	
	int getOrderPoint(String member_grade, int price);
	void registOrderPoint(int member_no, int price);
	MemberDto getMember(int member_no);
	MemberDto getMember(String member_id);
	String getMemberGrade(int member_no);
	int getGradeBenefitRate(String member_grade);
	boolean minusPointOrder(int member_no, int point);
	boolean checkPoint(int member_no, int point);
	void insertGoodsCartList(List<GoodsCartDto> goodsCartDtoList);
	void insertOptionCartList(List<OptionCartDto> optionCartDtoList);
	List<GoodsCartDto> getGoodsCartList(int member_no);
	List<GoodsCartDto> getGoodsCartList(String member_id);
	List<OptionCartDto> getOptionCartList(int member_no);
	List<OptionCartDto> getOptionCartList(String member_id);
	List<Integer> getGoodsOptionNoList(int goods_cart_no);
	void deleteCart(int goods_cart_no);
//////////////////////////////////////
	
	
// 회원 주문제작 Dao

	
//회원 정보 가입

		
		
//		MemberDto getMemberDto(int seq) throws Exception;
		
	// 멤버 테이블 시퀀스 생성
		int MemberSeq();
		
		
		// 회원 가입
		void regist(MemberDto member);
		
	
		//회원 로그인 
		MemberDto login(MemberDto member);
		
		//회원 최종로그인변동
		void lastLogin(MemberDto member);

		//세션에 있는 id를 통해 번호구하기
		int getNo(@RequestParam String member_id);

		
		public MemberDto memberGetOne(MemberDto member);
		
		//회원 탈퇴
		void memberdelete(MemberDto memberDto);
		
		
	
		
		
		





		


//		List<MemberDto> memberGetOne(int member_no);
		
//		//멤버아이디로 번호 구해오기 (영락)
//		int findno(@RequestParam MemberDto member, int member_no);


}

