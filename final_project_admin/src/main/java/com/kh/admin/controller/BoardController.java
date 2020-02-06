package com.kh.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {
	

	
	@GetMapping("/manageqna")
	public String manage() {
		return "board/manageqna";
	}
	
	//페이징을 위한 컨트롤러
	
}
