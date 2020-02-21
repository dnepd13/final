package com.kh.admin.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.admin.entity.OrderingDto;
import com.kh.admin.vo.ConnectListVO;
import com.kh.admin.vo.ConnectVO;
import com.kh.admin.vo.MonthlySalePriceVO;
import com.kh.admin.vo.ResultVO;
import com.kh.admin.vo.TopTenChartVO;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class SalesDaoImpl implements SalesDao{

	@Autowired
	private SqlSession sqlSession;
	@Override
	public List<ConnectListVO> connectList() {
		
		return sqlSession.selectList("admin.userDaily");
	}
	@Override
	public ResultVO dailySalePrice() {
//		log.info("들어오십니까!@");
		ResultVO result = sqlSession.selectOne("admin.dailySale");
		log.info("result={}",result);
		if(result !=null) {
		return result;
		}
		else {
			return result;
		}
	}
	@Override
	public ResultVO todaySaleCount() {
		
		ResultVO result = sqlSession.selectOne("admin.todaySaleCount");
		if(result !=null) {
			return result;
			}
		else {
				return result;
			}
	}
	@Override
	public ResultVO thisMonthSalePrice() {
		ResultVO result = sqlSession.selectOne("admin.thisMonthSalePrice");
		if(result !=null) {
			return result;
			}
		else {
				return result;
			}
	}
	@Override
	public ResultVO thisMonthSaleCount() {
		ResultVO result = sqlSession.selectOne("admin.thisMonthSaleCount");
		if(result !=null) {
			return result;
			}
		else {
				return result;
			}
	}
	@Override
	public ResultVO thisWeekSalePrice() {
		ResultVO result = sqlSession.selectOne("admin.thisWeekSalePrice");
		if(result !=null) {
			return result;
			}
		else {
				return result;
			}
	}
	@Override
	public ResultVO thisWeekSaleCount() {
		ResultVO result = sqlSession.selectOne("admin.thisWeekSaleCount");
		if(result !=null) {
			return result;
			}
		else {
				return result;
			}
	}
	@Override
	public List<MonthlySalePriceVO> monthlySalePriceChart() {
		return sqlSession.selectList("admin.monthlySalePrice");
	}
	@Override
	public ResultVO dailyCancel() {
		ResultVO result = sqlSession.selectOne("admin.dailyCancel");
		if(result !=null) {
			return result;
			}
		else {
				return result;
			}
	}
	@Override
	public ResultVO thisWeekCancel() {
		ResultVO result = sqlSession.selectOne("admin.thisWeekCancel");
		if(result !=null) {
			return result;
			}
		else {
				return result;
			}
	}
	@Override
	public ResultVO thisMonthCancel() {
		ResultVO result = sqlSession.selectOne("admin.thisMonthCancel");
		if(result !=null) {
			return result;
			}
		else {
				return result;
			}
	}
	@Override
	public List<TopTenChartVO> goodsTopTen() {
		log.info("여기5");
		return sqlSession.selectList("admin.goodsTopTen");
	}
	@Override
	public List<TopTenChartVO> priceTopTen() {
		return sqlSession.selectList("admin.priceTopTen");
	}
	@Override
	public List<TopTenChartVO> sellerTopTen() {
		return sqlSession.selectList("admin.sellerTopTen");
	}

}
