package com.kh.ordering.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.ordering.entity.FilesDto;
import com.kh.ordering.entity.PortfolioDto;
import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.CategoryDao;
import com.kh.ordering.repository.FilesDao;
import com.kh.ordering.repository.FilesPhysicalDao;
import com.kh.ordering.repository.PortfolioDao;
import com.kh.ordering.repository.SellerCategoryDao;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.SellerService;
import com.kh.ordering.vo.FilesVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/seller")
public class PortfolioController {
	@Autowired SellerDto sellerDto;
	@Autowired SellerDao sellerDao;
	@Autowired FilesDao filesDao;
	@Autowired FilesDto filesDto;
	@Autowired SellerCategoryDao sellerCategoryDao;
	@Autowired SellerService sellerService;
	@Autowired FilesPhysicalDao filesPysicalDao;
	@Autowired PortfolioDao portfolioDao;
	
	//판매자 포토폴리오 등록
@GetMapping("/portfolio_insert")
public String portfolio_insert(HttpSession session, Model model){
	
	String seller_id = (String)session.getAttribute("seller_id");
    int seller_no = sellerCategoryDao.getNo(seller_id);
    List<FilesVO> filesVO = portfolioDao.getFilesList(seller_no);
    if(filesVO!=null) {
    	model.addAttribute("filesVO", filesVO);
    }
    model.addAttribute("seller_no", seller_no);
  
	return "/seller/portfolio_insert";
	
}
//세션으로아이디를 받고 회번번호 꺼내오는거는seller_categorydo에 있음,
//파일을 등록한 후 파일 번호를 꺼내고 샐러 넘버와 파일넘버를 portfolioDto에 넣는다
	//판매자 포토폴리오 등록  5장까지 등록할 수 있음
@PostMapping("/portfolio_insert")
public String portfolio_insert(HttpSession session,
								@ModelAttribute FilesVO files,
								@ModelAttribute SellerDto sellerDto,				
								@ModelAttribute PortfolioDto portfolioDto)
										throws IllegalStateException,IOException {
		
           sellerService.Portfolio_insert(session,files,sellerDto);           
           
	      return "redirect:/seller/portfolio_insert";		
}

// 포트폴리오 삭제
@PostMapping("/portfolio_delete")
public String portfolio_delete(@ModelAttribute PortfolioDto portfolioDto) {
	portfolioDao.portfolio_delete(portfolioDto);
	return "redirect:/seller/portfolio_insert";
}

@GetMapping("/portfolio_download")
public ResponseEntity<ByteArrayResource> portfolio_download(@RequestParam int files_no) throws IOException {
	// DB 파일정보 불러오기
	FilesDto filesDto = filesDao.getFiles(files_no);

	// 실제 파일 불러오기
	byte[] data = filesPysicalDao.get(files_no);

	if(data==null) {
		return ResponseEntity.notFound().build();
	}
	
	ByteArrayResource resource = new ByteArrayResource(data);
	
	return ResponseEntity.ok()
											.contentType(MediaType.APPLICATION_OCTET_STREAM)
											.contentLength(filesDto.getFiles_size())
											.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+URLEncoder.encode(filesDto.getFiles_savename(),"UTF-8")+"\"")
											.body(resource);
}

}