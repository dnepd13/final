package com.kh.admin.exception;

import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.slf4j.Slf4j;
//@ControllerAdvice(annotations = Controller.class)
@Slf4j
@ControllerAdvice(basePackages = {"com.kh.admin"})
public class ErrorController {
	
	@ExceptionHandler(SQLException.class)
	public String sqlHandler(Exception ex) {
		log.error("DB예외발생", ex);
		return "error/500";
	}
	
	@ExceptionHandler(Exception.class)
	public String handler(Exception ex) {
		log.error("예외발생", ex);
		return "error/500";
	}
}
