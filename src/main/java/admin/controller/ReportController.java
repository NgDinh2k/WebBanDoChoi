package admin.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;


import ptithcm.bean.Statistic;
import ptithcm.bean.reportCharts;
import ptithcm.bean.reportDoubleColumnCharts;
import ptithcm.controller.LoginController;
import ptithcm.entity.CTDDH;
import ptithcm.entity.CTHD;
import ptithcm.entity.CTNHAPHANG;
import ptithcm.entity.HOADON;
import ptithcm.entity.NHAPHANG;


@Controller
@Transactional
@RequestMapping("/report/")
public class ReportController {
	@Autowired
	SessionFactory factory;
	
	@RequestMapping("reportBDCOT")
	public String index(ModelMap model)
	{
		model.addAttribute("nv", LoginController.nv);
		model.addAttribute("tk", LoginController.taikhoan);
		return "admin/view/reportBDCOT";
	}
	@RequestMapping("reportBDTRON")
	public String index2(ModelMap model)
	{
		model.addAttribute("nv", LoginController.nv);
		model.addAttribute("tk", LoginController.taikhoan);
		return "admin/view/reportBDTRON";
	}
	@RequestMapping("reportNhapHang")
	public String index3(ModelMap model)
	{
		model.addAttribute("nv", LoginController.nv);
		model.addAttribute("tk", LoginController.taikhoan);
		return "admin/view/reportNhapHang";
	}
	@RequestMapping("reportNhapHangXuatHang")
	public String index4(ModelMap model)
	{
		model.addAttribute("nv", LoginController.nv);
		model.addAttribute("tk", LoginController.taikhoan);
		return "admin/view/reportNhapHangXuatHang";
	}
	@ResponseBody
	@RequestMapping(value = "/findDoanhThu", method = RequestMethod.GET)
	public String findDoanhThu() throws JsonProcessingException 
	{
		List<reportCharts> list = findDoanhThus();
		
		ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		String json = ow.writeValueAsString(list);
		return json;
	}
	public List<HOADON> findAll()
	{
			Session session = factory.getCurrentSession();
			String hql = "FROM HOADON";
			Query query = session.createQuery(hql);
			List<HOADON> list = query.list();
			return list;

	}
	public List<reportCharts> findDoanhThus()
	{
		List<HOADON> list = findAll();
		
		Map<String,Integer> map = new HashMap<String,Integer>();
		for(HOADON a: list)
		{
			String ngaylapHD = a.getNgaylaphd().toString().substring(0,7);
			if(map.get(ngaylapHD)==null)
			{
				map.put(ngaylapHD, a.getTonggia());
			}
			else {
				map.put(ngaylapHD,a.getTonggia() + map.get(ngaylapHD));
			}
		}
		Map<String,Integer> treeMap = new TreeMap<>(map);
		List<reportCharts> listReport = new ArrayList<reportCharts>();
		for(String a : treeMap.keySet())
		{
			reportCharts re = new reportCharts();
			re.setLabel(a);
			re.setY(treeMap.get(a).doubleValue());
			listReport.add(re);
		}
		return listReport;
	}
	public List<reportCharts> findNH()
	{
		List<NHAPHANG> list = findAllNH();
		Map<String,Integer> map = new HashMap<String,Integer>();
		for(NHAPHANG a: list)
		{
			int tongGia =0;
			for(CTNHAPHANG x: a.getCTNHAPHANG())
			{
				tongGia += x.getDONGIA()*x.getSL();
			}
			a.setTongGia(tongGia);
			a.setNGAYNHAP(a.getNGAYNHAP().substring(0,7));
			if(map.get(a.getNGAYNHAP())==null)
			{
				map.put(a.getNGAYNHAP(), (int)a.getTongGia());
			}
			else {
				map.put(a.getNGAYNHAP(), (int) a.getTongGia() + map.get(a.getNGAYNHAP()));
			}
		}
		Map<String,Integer> treeMap = new TreeMap<>(map);
		List<reportCharts> listReport = new ArrayList<reportCharts>();
		for(String a : treeMap.keySet())
		{
			reportCharts re = new reportCharts();
			re.setLabel(a);
			re.setY(treeMap.get(a).doubleValue());
			listReport.add(re);
		}
		return listReport;
	}
	public List<NHAPHANG> findAllNH()
	{
			Session session = factory.getCurrentSession();
			String hql = "FROM NHAPHANG";
			Query query = session.createQuery(hql);
			List<NHAPHANG> list = query.list();
			return list;

	}
	@RequestMapping(value = "/findTKNhapHang", method = RequestMethod.GET)
	public String findTKNhapHang() throws JsonProcessingException
	{
		List<reportCharts> list = findNH();
		ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		String json = ow.writeValueAsString(list);
		return json;
	}
	
	
	
	
	@ResponseBody
	@RequestMapping(value = "/findTKNhapHangXuatHang", method = RequestMethod.GET)
	public String findTKNhapHangXuatHang() throws JsonProcessingException
	{
		List<reportDoubleColumnCharts> list =  findTKNhapHangXuatHang1();
		ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		String json = ow.writeValueAsString(list);
		return json;
	}
	public List<reportDoubleColumnCharts> findTKNhapHangXuatHang1()
	{
		List<reportDoubleColumnCharts> list = new ArrayList<reportDoubleColumnCharts>();
		List<reportCharts> listC1Report = findDoanhThus();
		List<reportCharts> listC2Report = findNH();
		
		for(reportCharts x:listC2Report)
		{
			x.setLabel(x.getLabel().replace("/", "-"));
			reportDoubleColumnCharts rp = new reportDoubleColumnCharts();
			rp.setLabel(x.getLabel());
			rp.setY2(x.getY());
			list.add(rp);
		}
		
		for(reportCharts x:listC1Report)
		{
			boolean kt = false;
			for(reportDoubleColumnCharts rp: list)
			{
				if(rp.getLabel().trim().equals(x.getLabel().trim()))
				{
					rp.setY(x.getY());
					kt= true;
				}
			}
			if(kt==false)
			{
				reportDoubleColumnCharts rp = new reportDoubleColumnCharts();
				rp.setLabel(x.getLabel());
				rp.setY(x.getY());
				list.add(rp);
			}
		}

		return list;
	}
	@ResponseBody
	@RequestMapping(value = "/findDoanhThu/{startDate}/{endDate}", method = RequestMethod.GET)
	public  String findDoanhThuTheoNgay(@PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate) throws ParseException, JsonProcessingException
	{
		List<HOADON> listBill = findAll();
		List<HOADON> listBillFilter = new ArrayList<HOADON>();
		Date startDates = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
		Date endDates = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
		for(HOADON hd : listBill)
		{
			 String sDate= hd.getNgaylaphd().toString().trim();  
			 Date date= new SimpleDateFormat("yyyy-MM-dd").parse(sDate); 
			 if(date.compareTo(endDates) <= 0 && date.compareTo(startDates)>=0)
			 {
				 listBillFilter.add(hd);
			 }
		}
		List<Statistic> listStatistic = new ArrayList<>();
		for(HOADON hd : listBillFilter)
		{
			boolean kt = true;
			for(Statistic statistic : listStatistic)
			{
				if(statistic.getDate().trim().equals(hd.getNgaylaphd().toString().trim()))
				{
					statistic.setMoney(statistic.getMoney() + (int) hd.getTonggia());
					statistic.setSlDH(statistic.getSlDH() +  1);
					kt = false;
				}
			}
			if(kt == true)
			{
				Statistic st = new Statistic();
				st.setDate(hd.getNgaylaphd().toString().trim());
				st.setMoney((int)hd.getTonggia());
				st.setSlDH(1);
				listStatistic.add(st);
			}
		}
		Collections.sort(listStatistic, new Comparator<Statistic>() {

			@Override
			public int compare(Statistic o1, Statistic o2) {
				try {
					return compareDate(o2.getDate(), o1.getDate());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return 0;
				}
			}

		});
		ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		String json = ow.writeValueAsString(listStatistic);
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/findNhapHang/{startDate}/{endDate}", method = RequestMethod.GET)
	public String findNhapHangTheoNgay(@PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate) throws ParseException, JsonProcessingException
	{
		List<NHAPHANG> listBill = findAllNH();
		List<NHAPHANG> listBillFilter = new ArrayList<NHAPHANG>();
		Date startDates = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
		Date endDates = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
		for(NHAPHANG hd : listBill)
		{
			 String sDate= hd.getNGAYNHAP().trim();  
			 Date date= new SimpleDateFormat("yyyy-MM-dd").parse(sDate); 
			 if(date.compareTo(endDates) <= 0 && date.compareTo(startDates)>=0)
			 {
				 listBillFilter.add(hd);
			 }
		}
		List<Statistic> listStatistic = new ArrayList<>();
		for(NHAPHANG hd : listBillFilter)
		{
			boolean kt = true;
			int tongTien1Don = 0;
			for(CTNHAPHANG ct : hd.getCTNHAPHANG())
			{
				tongTien1Don += ct.getDONGIA() * ct.getSL();
			}
			
			for(Statistic statistic : listStatistic)
			{
				if(statistic.getDate().trim().equals(hd.getNGAYNHAP().trim()))
				{
					statistic.setMoney(statistic.getMoney() + tongTien1Don);
					statistic.setSlDH(statistic.getSlDH() +  1);
					kt = false;
				}
			}
			if(kt == true)
			{
				Statistic st = new Statistic();
				st.setDate(hd.getNGAYNHAP().trim());
				st.setMoney(tongTien1Don);
				st.setSlDH(1);
				listStatistic.add(st);
			}
		}
		Collections.sort(listStatistic, new Comparator<Statistic>() {

			@Override
			public int compare(Statistic o1, Statistic o2) {
				try {
					return compareDate(o2.getDate(), o1.getDate());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return 0;
				}
			}

		});
		ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		String json = ow.writeValueAsString(listStatistic);
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "findDoanhThuThang/{startDate}/{endDate}", method = RequestMethod.GET)
	public String findDoanhThuTheoThang(@PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate) throws ParseException, JsonProcessingException
	{
		List<HOADON> listBill = findAll();
		List<HOADON> listBillFilter = new ArrayList<HOADON>();
		Date startDates = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
		Date endDates = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
		for(HOADON hd : listBill)
		{
			 String sDate= hd.getNgaylaphd().toString().trim();  
			 Date date= new SimpleDateFormat("yyyy-MM-dd").parse(sDate); 
			 if(date.compareTo(endDates) <= 0 && date.compareTo(startDates)>=0)
			 {
				 listBillFilter.add(hd);
			 }
		}
		List<Statistic> listStatistic = new ArrayList<>();
		for(HOADON hd : listBillFilter)
		{
			boolean kt = true;
			for(Statistic statistic : listStatistic)
			{
				if(statistic.getDate().equals(hd.getNgaylaphd().toString().trim().substring(0,7)))
				{
					statistic.setMoney(statistic.getMoney() + (int) hd.getTonggia());
					statistic.setSlDH(statistic.getSlDH() +  1);
					kt = false;
				}
			}
			if(kt == true)
			{
				Statistic st = new Statistic();
				st.setDate(hd.getNgaylaphd().toString().trim().substring(0,7));
				st.setMoney((int)hd.getTonggia());
				st.setSlDH(1);
				listStatistic.add(st);
			}
		}
		Collections.sort(listStatistic, new Comparator<Statistic>() {

			@Override
			public int compare(Statistic o1, Statistic o2) {
				try {
					return compareDateM(o2.getDate(), o1.getDate());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return 0;
				}
			}

		});
		ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		String json = ow.writeValueAsString(listStatistic);
		System.out.println(json);
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/findNhapHangThang/{startDate}/{endDate}", method = RequestMethod.GET)
	public String findNhapHangTheoThang(@PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate) throws ParseException, JsonProcessingException
	{
		System.out.println("VÔ ĐÂY FINDNHAPHANGTHANG");
		List<NHAPHANG> listBill = findAllNH();
		List<NHAPHANG> listBillFilter = new ArrayList<NHAPHANG>();
		Date startDates = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
		Date endDates = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
		for(NHAPHANG hd : listBill)
		{
			 String sDate= hd.getNGAYNHAP().trim();  
			 Date date= new SimpleDateFormat("yyyy-MM-dd").parse(sDate); 
			 if(date.compareTo(endDates) <= 0 && date.compareTo(startDates)>=0)
			 {
				 listBillFilter.add(hd);
			 }
		}
		List<Statistic> listStatistic = new ArrayList<>();
		for(NHAPHANG hd : listBillFilter)
		{
			boolean kt = true;
			
			int tongTien1Don = 0;
			for(CTNHAPHANG ct : hd.getCTNHAPHANG())
			{
				tongTien1Don += ct.getDONGIA() * ct.getSL();
			}
			hd.setTongGia(tongTien1Don);
			for(Statistic statistic : listStatistic)
			{
				if(statistic.getDate().equals(hd.getNGAYNHAP().trim().substring(0,7)))
				{
					statistic.setMoney(statistic.getMoney() + (int) hd.getTongGia());
					statistic.setSlDH(statistic.getSlDH() +  1);
					kt = false;
				}
			}
			if(kt == true)
			{
				Statistic st = new Statistic();
				st.setDate(hd.getNGAYNHAP().trim().substring(0,7));
				st.setMoney((int)hd.getTongGia());
				st.setSlDH(1);
				listStatistic.add(st);
			}
		}
		Collections.sort(listStatistic, new Comparator<Statistic>() {

			@Override
			public int compare(Statistic o1, Statistic o2) {
				try {
					return compareDateM(o2.getDate(), o1.getDate());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return 0;
				}
			}

		});
		ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		String json = ow.writeValueAsString(listStatistic);
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/findLoiNhuan/{startDate}/{endDate}", method = RequestMethod.GET)
	public String findLoiNhuan(@PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate) throws ParseException, JsonProcessingException
	{
		startDate = startDate.concat("-01");
		endDate = endDate.concat("-01");
		List<NHAPHANG> listBill = findAllNH();
		List<NHAPHANG> listBillFilter = new ArrayList<NHAPHANG>();
		Date startDates = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
		Date endDates = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
		for(NHAPHANG hd : listBill)
		{
			 String sDate= hd.getNGAYNHAP().trim();  
			 Date date= new SimpleDateFormat("yyyy-MM-dd").parse(sDate); 
			 if(date.compareTo(endDates) <= 0 && date.compareTo(startDates)>=0)
			 {
				 listBillFilter.add(hd);
			 }
		}
		List<Statistic> listStatistic = new ArrayList<>();
		for(NHAPHANG hd : listBillFilter)
		{
			boolean kt = true;
			
			int tongTien1Don = 0;
			for(CTNHAPHANG ct : hd.getCTNHAPHANG())
			{
				tongTien1Don += ct.getDONGIA() * ct.getSL();
			}
			hd.setTongGia(tongTien1Don);
			for(Statistic statistic : listStatistic)
			{
				if(statistic.getDate().equals(hd.getNGAYNHAP().trim().substring(0,7)))
				{
					statistic.setMoney2(statistic.getMoney2() + (int) hd.getTongGia());
					kt = false;
				}
			}
			if(kt == true)
			{
				Statistic st = new Statistic();
				st.setDate(hd.getNGAYNHAP().trim().substring(0,7));
				st.setMoney2((int)hd.getTongGia());
				listStatistic.add(st);
			}
		}
		
		List<HOADON> listHD = findAll();
		List<HOADON> listHDFilter = new ArrayList<HOADON>();
		for(HOADON hd : listHD)
		{
			 String sDate= hd.getNgaylaphd().toString().trim();  
			 Date date= new SimpleDateFormat("yyyy-MM-dd").parse(sDate); 
			 if(date.compareTo(endDates) <= 0 && date.compareTo(startDates)>=0)
			 {
				 listHDFilter.add(hd);
			 }
		}
		for(HOADON hd : listHDFilter)
		{
			boolean kt = true;
			for(Statistic statistic : listStatistic)
			{
				if(statistic.getDate().equals(hd.getNgaylaphd().toString().trim().substring(0,7)))
				{
					statistic.setMoney(statistic.getMoney() + (int) hd.getTonggia());
					kt = false;
				}
			}
			if(kt == true)
			{
				Statistic st = new Statistic();
				st.setDate(hd.getNgaylaphd().toString().trim().substring(0,7));
				st.setMoney((int)hd.getTonggia());
				listStatistic.add(st);
			}
		}
		
		for(Statistic st : listStatistic)
		{
			st.setProfit(st.getMoney() - st.getMoney2());
		}
		
		
		
		
		Collections.sort(listStatistic, new Comparator<Statistic>() {

			@Override
			public int compare(Statistic o1, Statistic o2) {
				try {
					return compareDateM(o2.getDate(), o1.getDate());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return 0;
				}
			}

		});
		ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		String json = ow.writeValueAsString(listStatistic);
		return json;
	}
	 public static int compareDate(String date1, String date2) throws ParseException
	 {
		 Date date1d = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
		 Date date2d = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
		 if(date1d.compareTo(date2d) < 0) return -1;
		 else if(date1d.compareTo(date2d) > 0) return 1;
		 else return 0;
	 }
	 public static int compareDateM(String date1, String date2) throws ParseException
	 {
		 Date date1d = new SimpleDateFormat("yyyy-MM-dd").parse(date1.concat("-00"));
		 Date date2d = new SimpleDateFormat("yyyy-MM-dd").parse(date2.concat("-00"));
		 if(date1d.compareTo(date2d) < 0) return -1;
		 else if(date1d.compareTo(date2d) > 0) return 1;
		 else return 0;
	 }
	
}
