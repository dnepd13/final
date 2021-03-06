package com.kh.admin.repository;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.AdminDto;
import com.kh.admin.entity.BlockDto;
import com.kh.admin.entity.CategoryDto;
import com.kh.admin.entity.FilesDto;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class AdminDaoImpl implements AdminDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private GoodsFilesDao goodsFilesDao;
	
	//사진 주소 여기만 바꾸면 됨
	private File directory = new File("D:/upload/kh2d");
	
	//로그인
	@Override
	public AdminDto login(AdminDto adminDto) {
		AdminDto login = sqlSession.selectOne("admin.getId", adminDto);
		return login;
	}

	//관리자 가입
	@Override
	public void regist(AdminDto adminDto) {
		log.info(adminDto.getAdmin_id());
		log.info(adminDto.getAdmin_grade());
		log.info(adminDto.getAdmin_email());
		log.info(adminDto.getAdmin_join_date());
		log.info(adminDto.getAdmin_last_login());
		log.info(adminDto.getAdmin_name());
		log.info(adminDto.getAdmin_pw());
		sqlSession.insert("admin.insert", adminDto);
	}

	//최종로그인일시변동
	@Override
	public void lastLogin(AdminDto adminDto) {
		sqlSession.update("admin.lastLogin", adminDto);
	}

	@Override
	public void block(BlockDto blockDto) {
		sqlSession.insert("admin.block", blockDto);
	}

	@Override
	public int blockCount() {
		return sqlSession.selectOne("admin.blockCount");
	}

	@Override
	public List<BlockDto> blockList(PagingVO paging) {
		List<BlockDto> list = sqlSession.selectList("admin.blockList", paging);
		return list;
	}

	@Override
	public void blockDelete(BlockDto blockDto) {
		sqlSession.delete("admin.blockDelete", blockDto);
	}

	@Override
	public int blockGroupCount(String block_group) {
		return sqlSession.selectOne("admin.blockGroupCount",block_group);
	}

	@Override
	public int blockIdCount(String block_id) {
		return sqlSession.selectOne("admin.blockIdCount", block_id);
	}

	@Override
	public int registToday() {
		int member = sqlSession.selectOne("admin.registTodayMember");
		log.info("member={}", member);
		int seller = sqlSession.selectOne("admin.registTodaySeller");
		log.info("seller={}", seller);
		return member+seller;
	}

	@Override
	public void blockUnlockSeller(BlockDto BlockDto) {
		sqlSession.delete("admin.blockDeleteSeller", BlockDto);
	}

	@Override
	public void blockUnlockMember(BlockDto BlockDto) {
		sqlSession.delete("admin.blockDeleteMember", BlockDto);
	}

	@Override
	public byte[] get(int files_no) throws IOException {
		FilesDto filesDto = goodsFilesDao.getFile(files_no);
		
		File file = new File(directory, filesDto.getFiles_savename());
		byte[] data = FileUtils.readFileToByteArray(file);
		return data;
	}

	@Override
	public int idcheck(String admin_id) {
		return sqlSession.selectOne("admin.idcheck", admin_id);
	}

	
	
	
}
