package com.kh.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.admin.entity.CalculateDto;
import com.kh.admin.repository.AdminDao;
import com.kh.admin.repository.CalculateDao;
import com.kh.admin.repository.GradeBenefitDao;
import com.kh.admin.repository.MemberDao;
import com.kh.admin.repository.PremiumDao;
import com.kh.admin.repository.SellerDao;
import com.kh.admin.vo.AdjustmentFullVO;
import com.kh.admin.vo.MemberPointVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SchedulerServiceImpl implements SchedulerService {

	@Autowired
	GradeBenefitDao gradeBenefitDao;

	@Autowired
	AdminDao loginDao;

	@Autowired
	private SellerDao sellerDao;

	@Autowired
	private CalculateDao calculateDao;

	@Autowired
	private PremiumDao premiumDao;

	@Autowired
	private MemberDao memberDao;
	
	
	
	@Override
	@Scheduled(cron = "0 42 9 * * *")
	public void test() {
			List<MemberPointVO> a = memberDao.limitPointList();
			log.info("a={}",a);
			for(int i = 0; i < a.size(); i++) {
				
				String date = a.get(i).getMember_point_date().substring(0, 10);
				String limit = a.get(i).getMember_point_limit().substring(0, 10);
				
				log.info("data={}",date);
				log.info("limit={}",limit);
				
				a.get(i).setMember_point_date(date);
				a.get(i).setMember_point_limit(limit);
				log.info("a={}", a.get(i));
				String b = memberDao.limitUsePoint(a.get(i));
				log.info("b={}",b);
				int c = Integer.parseInt(b);
				if(b == null) {
					int minusPoint = a.get(i).getMember_point_change()*-1;
					a.get(i).setMember_point_change(minusPoint);
					a.get(i).setMember_point_limit(limit);
					memberDao.extinctPoint(a.get(i));
					log.info("포인트 전액 소멸");
				}
				else {
					if(c*-1>a.get(i).getMember_point_change()) {
						log.info("포인트는 사라지지 않는다");
					}
					else {
						int minusPoint = (a.get(i).getMember_point_change() + Integer.parseInt(b))*-1;
						a.get(i).setMember_point_change(minusPoint);
						a.get(i).setMember_point_limit(limit);
						memberDao.extinctPoint(a.get(i));
						log.info("적립 포인트에서 사용된 포인트만큼 차감해서 소멸한다");
					}
				}
			}
		}
	
	@Override
//	@Scheduled(cron = "5 0 6 5 * ?")
	public void work() {
		log.info("실행됨?");
		List<String> a = calculateDao.scheduleCalculateGetSeller();
		log.info("a={}", a);
		for (int j = 0; j < a.size(); j++) {
			log.info(a.get(j));
			List<AdjustmentFullVO> list = calculateDao.scheduleCalcul(a.get(j));
			int total = 0;

			CalculateDto calculateDto = new CalculateDto();
			log.info("list={}", list);

			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getOrdering_status().equals("결제완료")) {
					total += list.get(i).getCart_info_goods_quantity() * list.get(i).getCart_info_goods_price();
					log.info("total1={}",
							list.get(i).getCart_info_goods_quantity() * list.get(i).getCart_info_goods_price());
				} else {
					total -= list.get(i).getCart_info_goods_quantity() * list.get(i).getCart_info_goods_price();
					log.info("total2={}",
							list.get(i).getCart_info_goods_quantity() * list.get(i).getCart_info_goods_price());
				}
			}

			log.info("total={}", total);

			int rate = calculateDao.getRate(total);
			int fee = total * rate / 100;
			int adjustment_price = total - fee;

			calculateDto.setSeller_no(list.get(j).getSeller_no());
			calculateDto.setCalculate_total(total);
			calculateDto.setCalculate_exception(fee);
			calculateDto.setCalculate_final(adjustment_price);
			calculateDto.setSeller_id(list.get(j).getSeller_id());

			calculateDao.scheduleCalculateInsert(calculateDto);
		}
	}
}
