package com.kh.admin.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice(annotations = Controller.class)
@Slf4j
public class ErrorController {
	
	@ExceptionHandler(SQLException.class)
	public String sqlHandler(Exception ex) {
		log.error("DB예외발생", ex);
		return "error/500";
	}
	
	@ExceptionHandler(Exception.class)
	public String handler(Exception ex) {
		log.error("예외발생!", ex);
		return "error/500";
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
    public String handleError404(HttpServletRequest request, Exception ex)   {
		log.error("없는페이지에러발생", ex);
		return "error/404";
	}
}
