package admin.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import javax.validation.constraints.Size;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
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

import ptithcm.bean.DetailImportInput;
import ptithcm.bean.ImportInput;
import ptithcm.controller.LoginController;
import ptithcm.entity.CTDDHk;
import ptithcm.entity.CTHD;
import ptithcm.entity.CTNHAPHANG;
import ptithcm.entity.DDHk;
import ptithcm.entity.DSTAIKHOAN;
import ptithcm.entity.DSTAIKHOANk;
import ptithcm.entity.HOADON;
import ptithcm.entity.KHACHHANGk;
import ptithcm.entity.NHANVIEN;
import ptithcm.entity.NHAPHANG;
import ptithcm.entity.SANPHAM;
import ptithcm.entity.SANPHAMk;

@Controller
@Transactional
@RequestMapping("/nhapHang/")
public class NhapHangController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("importList")
	public String index(ModelMap model, HttpServletRequest request) {
		List<ImportInput> listNH = findAll();
		model.addAttribute("listNhapHang", listNH);
		model.addAttribute("nv", LoginController.nv);
		model.addAttribute("tk", LoginController.taikhoan);
		return "admin/view/list-nhapHang";
	}

	@RequestMapping(value = "import/insert", method = RequestMethod.GET)
	public String insert(ModelMap model, @ModelAttribute("NH") ImportInput NH) {
		List<SANPHAMk> listSP = getProducts("");
		model.addAttribute("listSP", listSP);
		model.addAttribute("nv", LoginController.nv);
		model.addAttribute("tk", LoginController.taikhoan);
		return "admin/view/add-nhapHang";
	}

	@RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
	public String insert2(ModelMap model, @ModelAttribute("NH") ImportInput NH, @PathVariable("id") String id) {
		List<ImportInput> listNH = findAll();
		ImportInput x = new ImportInput();
		for (ImportInput im : listNH) {
			if (im.getID() == Integer.valueOf(id.trim())) {
				x = im;
				break;
			}
		}
		if (x.getListDetail() != null) {
			int tongTien = 0;
			for (DetailImportInput tam : x.getListDetail()) {
				tongTien += tam.getDONGIA() * tam.getSL();
			}
			model.addAttribute("tongTien", tongTien);
		}
		model.addAttribute("nv", LoginController.nv);
		model.addAttribute("nhaphang", x);
		model.addAttribute("tk", LoginController.taikhoan);
		return "admin/view/chitiet-nhaphang";
	}

	@RequestMapping(value = "import/add", method = RequestMethod.POST)
	public String add(ModelMap model,@ModelAttribute("NH") ImportInput NH)
	{
		System.out.println("add nhập hàng");
		List<DetailImportInput> listNH = new ArrayList<>();
		for(DetailImportInput x: NH.getListDetail())
		{
			if(x.getMaSanPham() != null)
			{
				System.out.println("MASP: "+x.getMaSanPham());
				DetailImportInput tam = new DetailImportInput();
				tam.setMaSanPham(x.getMaSanPham().trim());
				tam.setDONGIA(x.getDONGIA());
				tam.setSL(x.getSL());
				listNH.add(tam);
			}
		}
		NH.setListDetail(listNH);
		NHAPHANG nhapHang = ImportInput.convertToNHAPHANG(NH);
		System.out.println("CTNH:"+ nhapHang.getCTNHAPHANG().size());
		System.out.println("CTNH:"+ listNH.size());
		try
		{
			saveNH(nhapHang);
			
			model.addAttribute("message", "Nhập Hàng Thành Công !");
			model.addAttribute("link", "/nhapHang/importList");
		}
		catch (Exception e) {
			model.addAttribute("message", "Nhập Hàng Thất Bại !");
			model.addAttribute("link", "/nhapHang/importList");
		}
		
		model.addAttribute("nv", LoginController.nv);
		model.addAttribute("tk", LoginController.taikhoan);
		return "admin/view/Success";
	}

	public List<SANPHAMk> getProducts(String dieuKien) {
		Session session = factory.getCurrentSession();
		String hql = "FROM SANPHAMk " + dieuKien;
		Query query = session.createQuery(hql);
		List<SANPHAMk> list = query.list();
		return list;
	}

	

	public NHAPHANG saveNH(NHAPHANG nhapHang) {
		Session session = factory.getCurrentSession();
		session.save(nhapHang);
		for(CTNHAPHANG ctnh: nhapHang.getCTNHAPHANG())
		{
			ctnh.setMSNHAPHANG(nhapHang.getID());
			
			
			System.out.println(ctnh);
			SANPHAM sp = findOneByMaSP(ctnh.getSanPham().getMaSP());
			System.out.println(sp.getMasp());
			System.out.println(sp.getSoluongton());
			sp.setSoluongton(sp.getSoluongton() + ctnh.getSL());
			System.out.println(sp.getSoluongton());
			session.save(ctnh);
		
			
			saveSP(sp);
			System.out.println("Save " + sp.getTensp());
		}
		return nhapHang;
	}

	public void saveCTNH(CTNHAPHANG ctnhapHang, SANPHAM sp) {
		Session session = factory.getCurrentSession();
		session.save(ctnhapHang);
		session.save(sp);
		session.close();
	}


	public void saveSP(SANPHAM sp) {
		Session session = factory.openSession();
		String hql = "UPDATE SANPHAM set soluongton=:slt WHERE maSP=:idh";
		Query query = session.createQuery(hql);
		query.setParameter("idh", sp.getMasp());
		query.setParameter("slt", sp.getSoluongton());
		int result = query.executeUpdate();
		System.out.println(result);
		session.close();
	}

	public SANPHAM findOneByMaSP(String maSP) {
		Session session = factory.openSession();
		String hql = "FROM SANPHAM A " + "WHERE A.masp = "+ maSP;
		Query query;
		query = session.createQuery(hql);
		System.out.println(query);
		List<SANPHAM> list = query.list();
		SANPHAM sp = list.get(0);
		return sp;
	}

	public List<ImportInput> findAll() {
		Session session = factory.openSession();
		String hql = "FROM NHAPHANG ";
		Query query;
		query = session.createQuery(hql);
		List<NHAPHANG> list = query.list();
		List<ImportInput> listII = ImportInput.convertToListImportOutput(list);
		return listII;
	}
}
