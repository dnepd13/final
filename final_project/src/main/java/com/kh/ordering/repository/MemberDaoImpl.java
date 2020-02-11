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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;

	
//회원 번호 구하기 (영락)
	

		

		@Override // 요청서 저장
		public int MemberSeq() {
			return sqlSession.selectOne("member.MemberSeq");
		}

		@Override //회원가입
		public void regist(MemberDto member) {
			sqlSession.insert("member.regist", member); //세션값에 있는 regist를 저장
			
			}
		
		
		
		
		
		@Override //로그인
		public MemberDto login(MemberDto member) {
			return sqlSession.selectOne("member.login", member);
		}

		//최종 로그인 변동 하기
		@Override
		public void lastLogin(MemberDto member) {
		sqlSession.update("member.lastLogin", member);
			
		}

		@Override
		public int MemberNo(String member_id) {
			// TODO Auto-generated method stub
			return 0;
		}

//		//멤버 id로 번호 구하기
//		@Override
//		public int findno(MemberDto member,int member_no) {
//			
//			log.info("member_id= {}", member_id);
//			
//			
//	//맵퍼에 있는 정보를 불러오는것 mapper의 namespace member와 select항목의 finddo를 찾아 불러오는것
//	//parameterType(보내는값 int String vo, Dto등을 지정) 		
//			member_no = sqlSession.selectOne("member.findno", member_id);
//			log.info("member_no={}", member_no);
//			
//			return member_no;
//		} 


	

		
	
		
		
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
