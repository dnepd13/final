package com.kh.ordering.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/block")
public class BlockController {

	@GetMapping("/user")
	public String block() {
		return "block/user";
	}
}
