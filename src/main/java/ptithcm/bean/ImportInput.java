package ptithcm.bean;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.springframework.util.CollectionUtils;

import ptithcm.entity.CTNHAPHANG;
import ptithcm.entity.NHANVIEN;
import ptithcm.entity.NHAPHANG;



public class ImportInput {
	private int ID;
	private String NGAYNHAP;
	private String tenNhanVien;
	private int maNhanVien;
	private List<DetailImportInput> listDetail;
	public List<DetailImportInput> getListDetail() {
		return listDetail;
	}
	public void setListDetail(List<DetailImportInput> listDetail) {
		this.listDetail = listDetail;
	}
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	
	public String getNGAYNHAP() {
		return NGAYNHAP;
	}
	public void setNGAYNHAP(String nGAYNHAP) {
		NGAYNHAP = nGAYNHAP;
	}
	public String getTenNhanVien() {
		return tenNhanVien;
	}
	public void setTenNhanVien(String tenNhanVien) {
		this.tenNhanVien = tenNhanVien;
	}
	public int getMaNhanVien() {
		return maNhanVien;
	}
	public void setMaNhanVien(int maNhanVien) {
		this.maNhanVien = maNhanVien;
	}
	public static NHAPHANG convertToNHAPHANG(ImportInput nh)
	{
		NHAPHANG io= new NHAPHANG();
		if( nh == null) return null;
		io.setID(nh.getID());
		io.setNGAYNHAP(nh.getNGAYNHAP());
		NHANVIEN nv = new NHANVIEN();
		nv.setManv(nh.getMaNhanVien());
		io.setNhanVien(nv);
		List<CTNHAPHANG> listCTNH= new ArrayList<CTNHAPHANG>(); 
		for(DetailImportInput x: nh.getListDetail())
		{
			CTNHAPHANG ct = DetailImportInput.convertToCTNHAPHANG(x);
			ct.setMSNHAPHANG(nh.getID());
			listCTNH.add(ct);
		}
		io.setCTNHAPHANG(listCTNH);		
		return io;
	}
	public static ImportInput convertToImportOutput(NHAPHANG nh)
	{
		ImportInput io= new ImportInput();
		if( nh == null) return null;
		io.setID(nh.getID());
		io.setMaNhanVien(Integer.valueOf(nh.getNhanVien().getManv()));
		io.setNGAYNHAP(nh.getNGAYNHAP());
		io.setTenNhanVien(nh.getNhanVien().getHoten());
		List<DetailImportInput> listCTNH= new ArrayList<>(); 
		for (CTNHAPHANG x : nh.getCTNHAPHANG()) {
			DetailImportInput ct = DetailImportInput.convertToDetailImportOutput(x);
			listCTNH.add(ct);
		}
		io.setListDetail(listCTNH);
		return io;
	}
	public static List<ImportInput> convertToListImportOutput(List<NHAPHANG> nh)
	{
		List<ImportInput> io = new ArrayList<>();
		if (CollectionUtils.isEmpty(nh))
			return io;
		for (NHAPHANG x : nh) {
			io.add(convertToImportOutput(x));
		}
		return io;
	}
}
