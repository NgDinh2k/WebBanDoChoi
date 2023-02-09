package ptithcm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.entity.DSTAIKHOANk;
import ptithcm.entity.KHACHHANGk;
import ptithcm.entity.SANPHAMk;

@Transactional
@Controller
@RequestMapping("/user/")
public class UserController {
	@Autowired
	SessionFactory factory;
	
	@RequestMapping("logout")
	public String logout(ModelMap model,HttpServletRequest request,HttpSession ss)
	{
		HttpSession session = request.getSession();
		if(session.getAttribute("user")!=null)
		{
			session.removeAttribute("user");
			model.addAttribute("login","Login");
			return "login";
			
		}
		return "login";
	}
	
	@RequestMapping("changeInfor")
	public String index(ModelMap model,HttpServletRequest request,HttpSession ss) {
		HttpSession session = request.getSession();
		if(session.getAttribute("user")==null)
		{
			return "login";
		}
		else
		{
			DSTAIKHOANk a= (DSTAIKHOANk) session.getAttribute("user");
			model.addAttribute("tk",a);
			Session session1 = factory.getCurrentSession(); 
			String hql = "FROM KHACHHANGk where taiKhoan.taiKhoan='"+a.getTaiKhoan()+"'";
			Query query = session1.createQuery(hql); 
			KHACHHANGk user = (KHACHHANGk) query.list().get(0);
			model.addAttribute("KHACHHANG",user);
		}
		return "changeInfor";
	}
	@RequestMapping(value ="updateInfor",method=RequestMethod.POST)
	public String update(ModelMap model,HttpSession ss,HttpServletRequest request,@ModelAttribute("KHACHHANG") KHACHHANGk khachHang) {
		
		HttpSession session1 = request.getSession();
		khachHang.setTaiKhoan((DSTAIKHOANk) session1.getAttribute("user"));
		
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try
		{
			session.update(khachHang);
			t.commit();
			model.addAttribute("message","Cập Nhật Thành Công !");
		}
		catch(Exception e)
		{
			t.rollback();
			model.addAttribute("message","Cập Nhật Thất Bại !");
		}
		finally {
			session.close();
		}
		return "changeInfor";
	}
	
	@RequestMapping("changePassword")
	public String index1(ModelMap model,HttpServletRequest request,HttpSession ss) {
		HttpSession session = request.getSession();
		DSTAIKHOANk a= (DSTAIKHOANk) session.getAttribute("user");
		model.addAttribute("tk",a);
		return "changePassword";
	}
	
	@RequestMapping(value = "updatePassword",method=RequestMethod.POST)
	public String updatePass(ModelMap model,HttpSession ss,HttpServletRequest request) {
		String oldPass = request.getParameter("oldPass"); 
		String newPass = request.getParameter("newPass");
		String cfnewPass = request.getParameter("confirmNewPass");
	
		HttpSession session1 = request.getSession();
		DSTAIKHOANk a= (DSTAIKHOANk) session1.getAttribute("user");
		
		if(oldPass .equals(a.getMatKhau()))
		{
			if(newPass.equals(newPass))
			{
				a.setMatKhau(newPass);
			}
			else
			{
				model.addAttribute("message", "Mật Khẩu mới không khớp !");
				return "changePassword";
			}
		}
		else
		{
			model.addAttribute("message", "Sai Mật Khẩu cũ !");
			return "changePassword";
		}
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try
		{
			a.setChucVu("KHACH");
			session.update(a);
			t.commit();
			model.addAttribute("message","Cập Nhật Thành Công !");
		}
		catch(Exception e)
		{
			t.rollback();
			model.addAttribute("message","Cập Nhật Thất Bại !");
		}
		finally {
			session.close();
		}
		return "changePassword";
	}
	
	public List<SANPHAMk> getProducts(String dieuKien) {
		Session session = factory.getCurrentSession();
		String hql = "FROM SANPHAMk " + dieuKien;
		Query query = session.createQuery(hql);
		List<SANPHAMk> list = query.list();
		return list;
	}
}
