package com.kh.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sales")
public class SalesController {
	
	@GetMapping("/status")
	public String manage() {
		return "sales/status";
	}
}
