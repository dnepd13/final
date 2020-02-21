package com.kh.admin.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.admin.repository.CalculateDao;
import com.kh.admin.repository.PremiumDao;
import com.kh.admin.vo.CalculateVO;
import com.kh.admin.vo.FinalCalculateVO;
import com.kh.admin.vo.PagingVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CalculrateServiceImpl implements CalculrateService{

	@Autowired
	private CalculateDao calculateDao;
	
	@Autowired
	private PremiumDao premiumDao;
	
	@Override
	public List<FinalCalculateVO> calculrate(PagingVO vo1) {
		List<FinalCalculateVO> finish = new ArrayList<>();
		List<String> name = calculateDao.sellerCollect(vo1);
		log.info("name={}", name);
		log.info("size={}",name.size());
		for(int i = 0; i<name.size();i++) {
			String id = name.get(i);
			List<CalculateVO> vo = new ArrayList<>();
					vo=calculateDao.calculate(id);
				
				int total = 0;
				for(int j =0; j < vo.size(); j++ ) {
					int qu = vo.get(j).getCart_info_goods_quantity();
					int pri = vo.get(j).getCart_info_goods_price();
					total += qu*pri;
				}
				int rate = premiumDao.calculratePremium(total);
				FinalCalculateVO cal = new FinalCalculateVO();
				cal.setSeller_bank_account(vo.get(0).getSeller_bank_account());
				cal.setSeller_bank_code(vo.get(0).getSeller_bank_code());
				cal.setSeller_bank_username(vo.get(0).getSeller_bank_username());
				cal.setSeller_email(vo.get(0).getSeller_email());
				cal.setSeller_id(vo.get(0).getSeller_id());
				cal.setSeller_name(vo.get(0).getSeller_name());
				cal.setSeller_phone(vo.get(0).getSeller_phone());
				cal.setSeller_store_name(vo.get(0).getSeller_store_name());
				cal.setTotal(total);
				cal.setRate(rate);
				finish.add(cal);
			
		}
		return finish;
	}

}
