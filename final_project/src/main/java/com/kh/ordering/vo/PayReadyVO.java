package com.kh.ordering.vo;

public interface PayReadyVO {
	String getPartner_order_id();
	String getPartner_user_id();
	String getItem_name();
	int getQuantity();
	int getTotal_amount();
	int getVat_amount();
	int getTax_free_amount();
}
