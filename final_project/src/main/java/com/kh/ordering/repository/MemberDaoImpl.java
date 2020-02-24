package com.kh.ordering.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ordering.entity.CartInfoDto;
import com.kh.ordering.entity.MemberDto;
import com.kh.ordering.vo.MemberPointVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private MemberDao memberDao;

//	!지우지마세요, 포인트 관련  (월용) //////////////////////////
	
	// 회원 포인트 조회
	@Override
	public int getPoint(int member_no) {
		return sqlSession.selectOne("member.getPoint", member_no);
	}
	
	@Override
	public int getPoint(String member_id) {
		return this.getPoint(memberDao.getNo(member_id));
	}
	
	
	// 포인트 추가,차감
	@Override
	public void registPoint(MemberPointVO memberPointVO) {
		sqlSession.insert("member.registPoint", memberPointVO);
	}
	
	// 포인트 검사
	
	
	// 구매시 포인트 적용(상품가격 + 회원번호)
	@Override
	public void resgistOrderPoint(int member_no, int price) {
		
		String member_grade = this.getMemberGrade(member_no);
		int point = getOrderPoint(member_grade, price);
		
		MemberPointVO memberPointVO = MemberPointVO.builder()
					.member_point_status("적립")
					.member_point_change(point)
					.member_point_content("상품 구매")
					.member_no(member_no)
				.build();
		this.registPoint(memberPointVO);
	}
	
	@Override
	public int getOrderPoint(String member_grade, int price) {
		int rate = this.getGradeBenefitRate(member_grade);
		return price / 100 * rate;
	}
	
	@Override
	public int getGradeBenefitRate(String member_grade) {
		return sqlSession.selectOne("member.getGradeBenefitRate", member_grade);
	}
	
	@Override
	public String getMemberGrade(int member_no) {
		return sqlSession.selectOne("member.getMemberGrade", member_no);
	}
	
	@Override
	public MemberDto getMember(int member_no) {
		return sqlSession.selectOne("member.getMember", member_no);
	}
	
	@Override
	public MemberDto getMember(String member_id) {
		return this.getMember(this.getNo(member_id));
	}
//	!지우지마세요, 포인트 관련  (월용) //////////////////////////
//////////////////////////////////////	
	
	
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
		public int getNo(String member_id) {
			int member_no = sqlSession.selectOne("member.getNo", member_id);
			return member_no;
			
		}

		@Override
		public MemberDto memberGetOne(MemberDto member) {
			MemberDto result = sqlSession.selectOne("member.memberGetOne",member);
			return result;
		}

		@Override
		public void memberedit(MemberDto member) {
			sqlSession.update("member.memberedit", member);
			
		}

//		@Override
//		public List<MemberDto> memberGetOne(int member_no) {
//			
//			return sqlSession.selectOne("member.memberGetOne", member_no);
//		}



//		@Override
//		public void saveNO(MemberDto member) {
//			
//			member = ; 
//			
//		}

//		//멤버 id로 번호 구하기 (영락)
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
