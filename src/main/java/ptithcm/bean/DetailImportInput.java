package ptithcm.bean;

import ptithcm.entity.CTNHAPHANG;
import ptithcm.entity.SANPHAMk;

public class DetailImportInput {
	private int ID;
	private int SL;
	private int DONGIA;
	private String tenSanPham;
	private String maSanPham;
	private String hinhAnhSP;
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public int getSL() {
		return SL;
	}
	public void setSL(int sL) {
		SL = sL;
	}
	public int getDONGIA() {
		return DONGIA;
	}
	public void setDONGIA(int dONGIA) {
		DONGIA = dONGIA;
	}
	public String getTenSanPham() {
		return tenSanPham;
	}
	public void setTenSanPham(String tenSanPham) {
		this.tenSanPham = tenSanPham;
	}
	public String getMaSanPham() {
		return maSanPham;
	}
	public void setMaSanPham(String maSanPham) {
		this.maSanPham = maSanPham;
	}
	public String getHinhAnhSP() {
		return hinhAnhSP;
	}
	public void setHinhAnhSP(String hinhAnhSP) {
		this.hinhAnhSP = hinhAnhSP;
	}
	public static CTNHAPHANG convertToCTNHAPHANG(DetailImportInput dt)
	{
		CTNHAPHANG ct= new CTNHAPHANG();
		ct.setID(dt.getID());
		ct.setDONGIA(dt.getDONGIA());
		ct.setSL(dt.getSL());
		SANPHAMk sp = new SANPHAMk();
		sp.setMaSP(dt.getMaSanPham());
		ct.setSanPham(sp);
		return ct;
	}
	public static DetailImportInput convertToDetailImportOutput(CTNHAPHANG dt)
	{
		DetailImportInput ct= new DetailImportInput();
		ct.setID(dt.getID());
		ct.setMaSanPham(dt.getSanPham().getMaSP());
		ct.setTenSanPham(dt.getSanPham().getTenSP());
		ct.setHinhAnhSP(dt.getSanPham().getHinhAnh());
		ct.setSL(dt.getSL());
		ct.setDONGIA(dt.getDONGIA());
		return ct;
	}
}
