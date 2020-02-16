package com.kh.ordering.vo;


public interface PayReadyReturnVO {
	String getTid(); //DB에 저장해야할 항목
	String getNext_redirect_pc_url();
	String getCreated_at(); //
}
