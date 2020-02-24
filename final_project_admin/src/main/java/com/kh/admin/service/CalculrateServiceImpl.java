package com.kh.admin.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.admin.repository.CalculateDao;
import com.kh.admin.repository.PremiumDao;
import com.kh.admin.vo.AdjustmentFullVO;
import com.kh.admin.vo.AdjustmentInsertVO;
import com.kh.admin.vo.AdjustmentVO;
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
	public List<AdjustmentVO> getCalculSeller(PagingVO vo) {
		List<AdjustmentVO> finalCal = new ArrayList<>();
		List<String> a = calculateDao.calculateGetSeller(vo);
		log.info("a={}", a);
		for(int i=0; i<a.size(); i++) {
			AdjustmentVO resultvo = new AdjustmentVO();
			vo.setSeller_id(a.get(i));
			String seller_id = vo.getSeller_id();
			List<AdjustmentFullVO> b = new ArrayList<>();
			b = calculateDao.getCalculate(vo);
			log.info("b={}",b);
			log.info("bsize={}",b.size());
			int total = 0;	
				for(int j=0; j < b.size(); j++) {
					
					log.info("b.get(j).getOdering_status()={}",b.get(j).getOrdering_status());
					if(b.get(j).getOrdering_status().equals("결제완료")) {
						total += b.get(j).getCart_info_goods_quantity() * b.get(j).getCart_info_goods_price();
						log.info("total1={}",b.get(j).getCart_info_goods_quantity() * b.get(j).getCart_info_goods_price());
					}
					else {
						total -= b.get(j).getCart_info_goods_quantity() * b.get(j).getCart_info_goods_price();
						log.info("total2={}",b.get(j).getCart_info_goods_quantity() * b.get(j).getCart_info_goods_price());
					}
					log.info("total={}",total);
				}
			int rate = calculateDao.getRate(total);
			int fee = total * rate / 100;
			int adjustment_price = total - fee;
			resultvo.setFee(fee);
			resultvo.setAdjustment_price(adjustment_price);
			resultvo.setRate(rate);	
			resultvo.setTotal_cal_price(total);
			resultvo.setSeller_id(seller_id);
			log.info("result={}", resultvo.getTotal_cal_price());
			finalCal.add(resultvo);
		}	
		log.info("final={}", finalCal);
		return finalCal;
	}
	

}
