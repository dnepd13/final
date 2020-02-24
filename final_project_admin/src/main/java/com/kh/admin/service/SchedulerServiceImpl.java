package com.kh.admin.service;

import org.springframework.scheduling.annotation.Scheduled;

public class SchedulerServiceImpl implements SchedulerService{
	
	@Override
	@Scheduled(cron="0 0 12 L * ?")
	public void work() {
		
	}

}
