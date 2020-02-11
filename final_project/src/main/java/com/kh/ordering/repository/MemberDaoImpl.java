package com.kh.ordering.repository;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.CustomOrderDto;
import com.kh.ordering.entity.MemberCustomAlarmDto;
import com.kh.ordering.entity.MemberCustomOrderDto;
import com.kh.ordering.vo.CustomOrderVO;

import com.kh.ordering.entity.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;

	
//회원 번호 구하기 (영락)
	

		

		@Override
		public int MemberSeq() {
			return sqlSession.selectOne("member.MemberSeq");
		}

		@Override
		public void regist(MemberDto member) {
			sqlSession.insert("member.regist", member); //세션값에 있는 regist를 저장
			
		}



		
		
		
//		@Override
//		public MemberDto getMemberDto(int seq) throws Exception {
//			
//			MemberDto memberDto = sqlSession.selectOne("getMemberDto", seq);
//			return memberDto;
//		}

//		@Override
//		public MemberDto login(MemberDto memberDto) {
//			
//			return sqlSession.selectOne("member.login", memberDto);
//		}


		
	
	
}
