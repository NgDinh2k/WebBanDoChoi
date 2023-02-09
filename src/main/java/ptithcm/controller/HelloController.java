package ptithcm.controller;

import ptithcm.bean.Utility;
import ptithcm.controller.LoginController;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;


import ptithcm.entity.*;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.dom4j.rule.Mode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

@Transactional
@Controller
@SessionAttributes
public class HelloController {
	@Autowired
	SessionFactory factory;
	@Autowired
	ServletContext context;
	@Autowired
	JavaMailSender mailer;
	
	@RequestMapping("user/profile")
	public String showProfile(ModelMap model) {
		model.addAttribute("tk", LoginController.taikhoan);
		Session session = factory.getCurrentSession();
		String hql = "FROM NHANVIEN A WHERE A.manv=:idnv ";
		Query query = session.createQuery(hql);
		query.setParameter("idnv", LoginController.nv.getManv());
		List<NHANVIEN> list = query.list();
		NHANVIEN nhanvien=list.get(0);
		model.addAttribute("Nhanvien",nhanvien);
		return "user/FormProfileNhanvien";
	}
	
	@RequestMapping(value = "user/update", method = RequestMethod.POST)
	public String UpdateNV(ModelMap model,@Validated@ModelAttribute("Nhanvien") NHANVIEN nv,BindingResult errors) 
	{
		
		
		
		
		model.addAttribute("tk", LoginController.taikhoan);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		String hql = "FROM NHANVIEN A WHERE A.manv=:idnv ";
		Query query = session.createQuery(hql);
		query.setParameter("idnv", nv.getManv());
		
		List<NHANVIEN> list = query.list();
		NHANVIEN nhanvienSua=list.get(0);
		nhanvienSua.setHoten(nv.getHoten());
		nhanvienSua.setDiachi(nv.getDiachi());
		nhanvienSua.setSdt(nv.getSdt());
		nhanvienSua.setEmail(nv.getEmail());

		try {
			session.update(nhanvienSua);
			t.commit();
			model.addAttribute("message", "update nhân viên thành công!");	
			model.addAttribute("link", "profile");
		} catch (Exception e) {

			model.addAttribute("message", "update nhân viên thất bại!"+e.getMessage());
			model.addAttribute("link", "profile");
		} 
		return "user/Success-order";
	}
	
	
	public Integer laymaSP()
	{
		Session session = factory.getCurrentSession();
		String hql = "select max( CAST(masp AS int)) from SANPHAM";
		Query query = session.createQuery(hql);
		List<Integer> list = query.list();
		Integer masp=list.get(0);
		return masp;
	}
	public String taomaSP()
	{
		Integer ma=laymaSP();
		if(ma==null)
		{
			ma=1;
		}
		else
		{
			ma=ma+1;
		}
		return ma.toString();
	}
	public Integer laymaHD()
	{
		Session session = factory.getCurrentSession();
		String hql = "select max(CAST(sohd AS int)) from HOADON ";
		Query query = session.createQuery(hql);
		List<Integer> list = query.list();
		Integer mahd=list.get(0);
		return mahd;
	}
	public String taomaHD()
	{
		Integer ma=laymaHD();
		if(ma==null)
		{
			ma=1;
		}
		else {
			ma=ma+1;	
		}
		return ma.toString();
	}
	@RequestMapping("user/products")
	public String showFormproduct(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM SANPHAM A WHERE A.trangthaixoa='0'order by length(A.masp), masp";
		Query query = session.createQuery(hql);
		List<SANPHAM> list = query.list();
		model.addAttribute("products", list);
		model.addAttribute("tk", LoginController.taikhoan);
		
		
		return "user/Product";
	}
	@RequestMapping("user/products/edit")
	public String editProduct() {
		return "user/EditProduct";
	}
	
	@RequestMapping("user/order/success")
	public String success() {
		return "user/Success-order";
	}
	
	
	@RequestMapping("user/order")
	public String index1(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM DONDATHANG order by msddh DESC";
		Query query = session.createQuery(hql);
		List<DONDATHANG> list = query.list();
		model.addAttribute("tk", LoginController.taikhoan);
		
		model.addAttribute("dondh", list);
		return "user/order";
	}
	
	@RequestMapping("user/order/{id}")
	public String indexPersonal(ModelMap model) {
		Integer manv=LoginController.nv.getManv();
		Session session = factory.getCurrentSession();
		String hql = "FROM NHANVIEN WHERE manv= :nvx" ;
		Query query = session.createQuery(hql);
		query.setParameter("nvx", manv);
		List<NHANVIEN> list = query.list();
		NHANVIEN nv=list.get(0);
		List<DONDATHANG> dsddh=new ArrayList<DONDATHANG>();
		for(HOADON x:nv.getHoadonlist())
		{
			dsddh.add(x.getDondathang());
		}
		model.addAttribute("tk", LoginController.taikhoan);
		
		model.addAttribute("dondh", dsddh);
		
		return "user/order";

	}
	
	@RequestMapping(value = "user/order", method = RequestMethod.POST,params="btnAccept")
	public String UpdateDDH(@RequestParam("id") String id,ModelMap model)
	{
		
		try {
			model.addAttribute("tk", LoginController.taikhoan);
			
			MimeMessage mail=mailer.createMimeMessage();
			MimeMessageHelper helper=new MimeMessageHelper(mail);
			id=id.trim();
			HOADON hd=new HOADON();
			Session session = factory.getCurrentSession();
			String hql = "UPDATE DONDATHANG set trangthai=:success WHERE msddh=:idh";
			Query query = session.createQuery(hql);
			query.setParameter("success", "CONFIRMED");
			query.setParameter("idh", id);
			int result=query.executeUpdate();
			String hqlNV = "FROM NHANVIEN X WHERE manv=:idnv";
			Query queryNV= session.createQuery(hqlNV);
			queryNV.setParameter("idnv",LoginController.nv.getManv());
			List<NHANVIEN> list1 = queryNV.list();
			
			NHANVIEN nv=list1.get(0);
			String hqlDH = "FROM DONDATHANG Y WHERE msddh=:ms";
			Query queryDH= session.createQuery(hqlDH);
			queryDH.setParameter("ms",id);
			List<DONDATHANG> list2 = queryDH.list();
			DONDATHANG dh=list2.get(0);

			hd.setSohd(taomaHD());
			System.out.println(hd.getSohd());
			Date dNow=new Date();
			hd.setNgaylaphd(dNow);

			hd.setNhanvien(nv);
			hd.setDondathang(dh);
			Integer Tong=0;
			String listdh="";
			 for (CTDDH e: hd.getDondathang().getCtddhlist() ) 
			 {
				 listdh=listdh+"<br>"+e.getSanpham().getTensp()+"-Số lượng: "+e.getSL();
				 Integer slt=e.getSanpham().getSoluongton()-e.getSL();
				 if(slt>=0) {
					 
					 Tong=Tong+e.getSL()*e.getSanpham().getDongia();	
				 }
				 else {
					 	hd.getDondathang().setTrangthai("CANCELLED");
					 	helper.setTo(dh.getEmail());
						helper.setReplyTo(Utility.mail);	
						helper.setSubject("Xác nhận đơn hàng thất bại");
						String body="Rất xin lỗi quý khách vì sự bất tiện này do số lượng sản phẩm "+e.getSanpham().getTensp()+
								" không đủ nên đơn hàng đã bị hủy !";
						helper.setText(body,true);
						mailer.send(mail);
						
						model.addAttribute("message", "Xác nhận đơn hàng thất bại <br>   Lý do:số lượng không đủ !");
						model.addAttribute("link", "order");
						return "user/Success-order";
				 }
				 
			 }
			 for (CTDDH e: hd.getDondathang().getCtddhlist() ) {
				 Integer slt=e.getSanpham().getSoluongton()-e.getSL();
				 e.getSanpham().setSoluongton(slt);
			 }
			hd.setTonggia(Tong);
			hd.setFeedback("xịn");			
			session.save(hd);
			Calendar c = Calendar.getInstance();
			c.setTime(dNow);
			c.add(Calendar.DATE,4);
			 Date currentDatePlusOne = c.getTime();
			 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			 String strDate=formatter.format(currentDatePlusOne);
			
			helper.setTo(dh.getEmail());
			helper.setReplyTo(Utility.mail);	
			helper.setSubject("Xác nhận đơn hàng thành công !");
			String body="<p>số hóa đơn: "+hd.getSohd()+"</p>"+"<p>tên khách hàng: "+hd.getDondathang().getHotenkh()+ "</p>"+"<p>địa chỉ: "+hd.getDondathang().getDiachi()+"</p>"+"<p>Số điện thoại: "+hd.getDondathang().getSDT()
					+"</p>"+"<p>Giỏ hàng: "+listdh+"</p>"
					+"<p>Tổng giá: "+hd.getTonggia()+"</p>"+"<p>Thời gian dự kiến giao hàng: "+strDate+"</p>";
			helper.setText(body,true);
			mailer.send(mail);
			model.addAttribute("message", "Xác nhận đơn hàng thành công !");
			model.addAttribute("link", "order");
			
		}
		catch(Exception e){
			model.addAttribute("message", "Xác nhận đơn hàng thất bại !"+e.getMessage());
			
			model.addAttribute("link", "order");
		}
		return "user/Success-order";
	}
	
	@RequestMapping("/user/products/{id}")
	public String deleteSP(@PathVariable String id,ModelMap model)
	{
		model.addAttribute("tk", LoginController.taikhoan);
		
		try {
			id=id.trim();
			Query query;
			String hql="";
			int result;
			Session session = factory.openSession();
			hql="FROM SANPHAM A "  + 
		             "WHERE A.masp = :ddh";
			query = session.createQuery(hql);
			query.setParameter("ddh", id);
			List<SANPHAM> list = query.list();
			SANPHAM sp=list.get(0);
			if(sp.getCtddhlist().size()>0)
			{
				  model.addAttribute("message", "Sản phẩm này không thể xóa cứng => xoá mềm  !");	
				  
					String hql1 = "FROM SANPHAM A WHERE A.trangthaixoa='0'";
					Query query1 = session.createQuery(hql1);
					List<SANPHAM> list1 = query1.list();
					model.addAttribute("products", list1);
				  return "user/Product";
			}
//			for (CTDDH e:sp.getCtddhlist() )
//			{
//				
//			  if(e.getDondathang().getTrangthai().trim().equals("NEW"))
//			  {
//				  model.addAttribute("message", "Sản phẩm này không thể xóa  !");	
//				  
//					String hql1 = "FROM SANPHAM A WHERE A.trangthaixoa='0'";
//					Query query1 = session.createQuery(hql1);
//					List<SANPHAM> list1 = query1.list();
//					model.addAttribute("products", list1);
//				  return "user/Product";
//			  }
//			}			
				hql="UPDATE FROM SANPHAM set trangthaixoa='1' "  + 
		         "WHERE masp = :product_id";
			 	query = session.createQuery(hql);
			 	query.setParameter("product_id", id);
			 	result = query.executeUpdate();
		}
		catch (Exception e) {
			model.addAttribute("message", "xóa sản phẩm thất bại!");	
			model.addAttribute("link", "products");
			return "user/Success-order";
		}

		return "redirect:/user/products.htm ";
	}
	@RequestMapping("/user/order/delete")
	public String deleteOrder(@RequestParam("id") String id,ModelMap model)
	{
		model.addAttribute("tk", LoginController.taikhoan);
		
		
		id=id.trim();
		Session session = factory.getCurrentSession();
		String hql1 = "FROM DONDATHANG WHERE msddh=:ip";
		Query query1 = session.createQuery(hql1);
		query1.setParameter("ip", id);
		List<DONDATHANG> list = query1.list();
		DONDATHANG a=list.get(0);
		if(a.getTrangthai().equals("CONFIRMED"))
		{
			for (CTDDH e: a.getCtddhlist() ) {
				 Integer slt=e.getSanpham().getSoluongton()+e.getSL();
				 e.getSanpham().setSoluongton(slt);
			 }
		}
		String hql = "UPDATE DONDATHANG set trangthai=:cancel WHERE msddh=:idh";
		Query query = session.createQuery(hql);
		query.setParameter("cancel", "CANCELLED");
		query.setParameter("idh", id);
		int result=query.executeUpdate();
		
		return "redirect:/user/order.htm ";
	}
	
	@RequestMapping(value = "user/order/detail", method = RequestMethod.POST)
	public String DetailOrder(@ModelAttribute("id") String id,ModelMap model)
	{
		model.addAttribute("tk", LoginController.taikhoan);
		id.trim();
		Session session = factory.getCurrentSession();
		String hql="FROM DONDATHANG X "  + 
	             " WHERE X.msddh = :ddh";
		Query query = session.createQuery(hql);
		query.setParameter("ddh", id);
		List<DONDATHANG> list = query.list();
		DONDATHANG a=list.get(0);
		model.addAttribute("ctddh", a);
		model.addAttribute("linkx", "order");
		Integer Tong=0;
		   for (CTDDH e: a.getCtddhlist())
		   {
			   Tong=Tong+e.getSL()*e.getSanpham().getDongia();
		   }
		   model.addAttribute("Tonggia", Tong);
		return "user/Detail";
	}
	
	@RequestMapping(value = "user/order/order/detail", method = RequestMethod.POST)
	public String DetailOrder2(@ModelAttribute("id") String id,ModelMap model)
	{
		id.trim();
		Session session = factory.getCurrentSession();
		String hql="FROM DONDATHANG X "  + 
	             " WHERE X.msddh = :ddh";
		Query query = session.createQuery(hql);
		query.setParameter("ddh", id);
		List<DONDATHANG> list = query.list();
		DONDATHANG a=list.get(0);
		model.addAttribute("ctddh", a);
		model.addAttribute("linkx", "order/personal");
		Integer Tong=0;
		   for (CTDDH e: a.getCtddhlist())
		   {
			   Tong=Tong+e.getSL()*e.getSanpham().getDongia();
		   }
		   model.addAttribute("Tonggia", Tong);
		return "user/Detail";
	}
	
	@RequestMapping(value = "/user/products/edit/{id}", method = RequestMethod.GET) 
	public String editProduct(@PathVariable String id ,ModelMap model) { 
		model.addAttribute("tk", LoginController.taikhoan);
		
		id=id.trim();
		Session session = factory.getCurrentSession();
		String hql="FROM SANPHAM X "  + 
	             " WHERE X.masp = :product_id";
		Query query = session.createQuery(hql);
		query.setParameter("product_id", id);
		List<SANPHAM> list = query.list();
		SANPHAM a=list.get(0);
		model.addAttribute("product", a);
        List<String> list2 = Arrays.asList("FullBox","Assembling","NoBox","Wisdom","Classic");
        List<String> list3 =Arrays.asList("USA","CHINA","VIETNAM","THAILAND","INDIA","SPAIN","KOREA");
		model.addAttribute("loaisps", list2);
		model.addAttribute("nuoc", list3);
		return "user/EditProduct";
	}
	@RequestMapping(value = "/user/products/edit/update", method = RequestMethod.POST)
	public String Update(ModelMap model,@Validated@ModelAttribute("product") SANPHAM sp,BindingResult errors, @RequestParam("photo") MultipartFile photo) {
		model.addAttribute("tk", LoginController.taikhoan);
		
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		 List<String> list2 = Arrays.asList("FullBox","Assembling","NoBox","Wisdom","Classic");
	        List<String> list3 =Arrays.asList("USA","CHINA","VIETNAM","THAILAND","INDIA","SPAIN","KOREA");
		model.addAttribute("loaisps", list2);
		model.addAttribute("nuoc", list3);
		try {
			if(errors.hasErrors())
			{
				
				return "user/EditProduct";
			}
			sp.setTrangthaixoa(0);
			sp.setSale((float) 0);
			session.update(sp);
			t.commit();
			try
			{
				String photoPath = Utility.folder+ sp.getHinhanh();
				System.out.println(photoPath);
				photo.transferTo(new File(photoPath));
			}
			catch(Exception e)
			{
				System.out.println("loi luu file");
			}
			model.addAttribute("message", "update sản phẩm thành công!");	
			model.addAttribute("link", "products");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "update sản phẩm thất bại!");
			model.addAttribute("link", "products");
		} finally {
			session.close();
		}
		return "user/Success-order";
	}
	@RequestMapping(value = "user/products/create", method = RequestMethod.GET)
	public String insert(ModelMap model) {
		model.addAttribute("tk", LoginController.taikhoan);
		
		model.addAttribute("product", new SANPHAM());
		 List<String> list2 = Arrays.asList("FullBox","Assembling","NoBox","Wisdom","Classic");
	        List<String> list3 =Arrays.asList("USA","CHINA","VIETNAM","THAILAND","INDIA","SPAIN","KOREA");
		model.addAttribute("loaisps", list2);
		model.addAttribute("nuoc", list3);
		
		return "user/CreateProduct";
	}
	
	@RequestMapping(value = "/user/products/create", method = RequestMethod.POST)
	public String insert(ModelMap model, @Validated@ModelAttribute("product") SANPHAM sp,BindingResult errors,@RequestParam("photo") MultipartFile photo) {
		model.addAttribute("tk", LoginController.taikhoan);
		
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			 List<String> list2 = Arrays.asList("FullBox","Assembling","NoBox","Wisdom","Classic");
		        List<String> list3 =Arrays.asList("USA","CHINA","VIETNAM","THAILAND","INDIA","SPAIN","KOREA");
			model.addAttribute("loaisps", list2);
			model.addAttribute("nuoc", list3);
		try {
			if(errors.hasErrors())
			{
				
				return "user/CreateProduct";
			}
			sp.setTrangthaixoa(0);
			sp.setMasp(taomaSP());
			sp.setSale(Float.valueOf(0));
			session.save(sp);
			t.commit();
			try
			{
				String photoPath = Utility.folder+ sp.getHinhanh();
				System.out.println(photoPath);
				photo.transferTo(new File(photoPath));
			}
			catch(Exception e)
			{
				System.out.println("loi luu file");
			}
			model.addAttribute("message", "Thêm sản phẩm mới thành công!");
			model.addAttribute("link", "products");

		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Thêm sản phẩm mới thất bại!"+e.getMessage());
		} finally {
			session.close();
		}
		return "user/Success-order";

	}

}
