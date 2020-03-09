//package com.kh.admin.service;
//
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.scheduling.annotation.Scheduled;
//import org.springframework.stereotype.Service;
//
//import com.kh.admin.entity.CalculateDto;
//import com.kh.admin.repository.AdminDao;
//import com.kh.admin.repository.CalculateDao;
//import com.kh.admin.repository.GradeBenefitDao;
//import com.kh.admin.repository.PremiumDao;
//import com.kh.admin.repository.SellerDao;
//import com.kh.admin.vo.AdjustmentFullVO;
//
//import lombok.extern.slf4j.Slf4j;
//
//@Service
//@Slf4j
//public class SchedulerServiceImpl implements SchedulerService {
//
//	@Autowired
//	GradeBenefitDao gradeBenefitDao;
//
//	@Autowired
//	AdminDao loginDao;
//
//	@Autowired
//	private SellerDao sellerDao;
//
//	@Autowired
//	private CalculateDao calculateDao;
//
//	@Autowired
//	private PremiumDao premiumDao;
//
//	@Override
//	@Scheduled(fixedRate = 1000)
//	public void test() {
//		log.info("실행됨?");
//	}
//
//	@Override
//	@Scheduled(cron = "5 0 6 5 * ?")
//	public void work() {
//		log.info("실행됨?");
//		List<String> a = calculateDao.scheduleCalculateGetSeller();
//		log.info("a={}", a);
//		for (int j = 0; j < a.size(); j++) {
//			log.info(a.get(j));
//			List<AdjustmentFullVO> list = calculateDao.scheduleCalcul(a.get(j));
//			int total = 0;
//
//			CalculateDto calculateDto = new CalculateDto();
//			log.info("list={}", list);
//
//			for (int i = 0; i < list.size(); i++) {
//				if (list.get(i).getOrdering_status().equals("결제완료")) {
//					total += list.get(i).getCart_info_goods_quantity() * list.get(i).getCart_info_goods_price();
//					log.info("total1={}",
//							list.get(i).getCart_info_goods_quantity() * list.get(i).getCart_info_goods_price());
//				} else {
//					total -= list.get(i).getCart_info_goods_quantity() * list.get(i).getCart_info_goods_price();
//					log.info("total2={}",
//							list.get(i).getCart_info_goods_quantity() * list.get(i).getCart_info_goods_price());
//				}
//			}
//
//			log.info("total={}", total);
//
//			int rate = calculateDao.getRate(total);
//			int fee = total * rate / 100;
//			int adjustment_price = total - fee;
//
//			calculateDto.setSeller_no(list.get(j).getSeller_no());
//			calculateDto.setCalculate_total(total);
//			calculateDto.setCalculate_exception(fee);
//			calculateDto.setCalculate_final(adjustment_price);
//			calculateDto.setSeller_id(list.get(j).getSeller_id());
//
//			calculateDao.scheduleCalculateInsert(calculateDto);
//		}
//	}
//}
