package ptithcm.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="NHAPHANG")
public class NHAPHANG {
	
	@Id
	@GeneratedValue
	private int ID;
	private String NGAYNHAP;
	
	 @ManyToOne
	 @JoinColumn(name="MANV") 
	 private NHANVIEN nhanVien;
	 
	 @OneToMany(mappedBy ="MSNHAPHANG",fetch = FetchType.EAGER) 
	  private List<CTNHAPHANG> CTNHAPHANG;
	 
	 @Transient
	 private int tongGia;
	 
	 
	 
	public List<CTNHAPHANG> getCTNHAPHANG() {
		return CTNHAPHANG;
	}

	public void setCTNHAPHANG(List<CTNHAPHANG> cTNHAPHANG) {
		CTNHAPHANG = cTNHAPHANG;
	}

	public int getTongGia() {
		return tongGia;
	}

	public void setTongGia(int tongGia) {
		this.tongGia = tongGia;
	}

	public NHANVIEN getNhanVien() {
		return nhanVien;
	}

	public void setNhanVien(NHANVIEN nhanVien) {
		this.nhanVien = nhanVien;
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
}
