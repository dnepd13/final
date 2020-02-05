package com.kh.ordering.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ordering.entity.SellerDto;
import com.kh.ordering.repository.SellerDao;
import com.kh.ordering.service.SellerService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/seller")
public class SellerController {
	@Autowired
	private SellerService sellerService;
	
	@GetMapping("/regist")
	public String regist() {
		return "seller/regist";	
	}
	@PostMapping("/regist")
	public String regist(@ModelAttribute SellerDto sellerDto) {
		
//		log.info("1=[]",sellerDto.getSeller_addr_basic());
//		log.info("1=[]",sellerDto.getSeller_addr_extra());
//		log.info("1=[]",sellerDto.getSeller_addr_post());
//		log.info("1=[]",sellerDto.getSeller_agree_date());
//		log.info("1=[]",sellerDto.getSeller_bank_account());
//		log.info("1=[]",sellerDto.getSeller_bank_birth());
//		log.info("1=[]",sellerDto.getSeller_bank_code());
//		log.info("1=[]",sellerDto.getSeller_bank_username());
//		log.info("1=[]",sellerDto.getSeller_birth());
//		log.info("1=[]",sellerDto.getSeller_cid());
//		log.info("1=[]",sellerDto.getSeller_email());
//		log.info("1=[]",sellerDto.getSeller_grade());
//		log.info("1=[]",sellerDto.getSeller_id());
//		log.info("1=[]",sellerDto.getSeller_join_date());
//		log.info("1=[]",sellerDto.getSeller_last_login());
//		log.info("1=[]",sellerDto.getSeller_name());
//		log.info("1=[]",sellerDto.getSeller_phone());
//		log.info("1=[]",sellerDto.getSeller_pw());
//		log.info("1=[]",sellerDto.getSeller_store_fax());
//		log.info("1=[]",sellerDto.getSeller_store_name());
//		log.info("1=[]",sellerDto.getSeller_store_phone());
		sellerService.regist(sellerDto);
		return"redirect:/";
	}
	
}
