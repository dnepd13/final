package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.PremiumDto;

public interface PremiumDao {
	public List<PremiumDto> premiumGetList();
	public void premiumInsert(PremiumDto premiumDto);
	public void premiumUpdate(PremiumDto premiumDto);
	public void premiumDelete(PremiumDto premiumDto);
}
