package com.kh.admin.repository;

import java.util.List;

import com.kh.admin.entity.GradeBenefitDto;

public interface GradeBenefitDao {
	public void gradeBenefitRegist(GradeBenefitDto gradeBenefitDto);
	public List<GradeBenefitDto> gradeBenefitList();
	public void gradeBenefitUpdate(GradeBenefitDto gradeBenefitDto);
	public void gradeBenefitDelete(GradeBenefitDto gradeBenefitDto);
}
