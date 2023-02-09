package ptithcm.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="CTNHAPHANG")
public class CTNHAPHANG {

	@Id
	@GeneratedValue
	private int ID;
	@ManyToOne
	@JoinColumn(name="MASP") 
	private SANPHAMk sanPham;
	private int SL;
	private int DONGIA;
	private int MSNHAPHANG;
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public SANPHAMk getSanPham() {
		return sanPham;
	}
	public void setSanPham(SANPHAMk sanPham) {
		this.sanPham = sanPham;
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
	public int getMSNHAPHANG() {
		return MSNHAPHANG;
	}
	public void setMSNHAPHANG(int mSNHAPHANG) {
		MSNHAPHANG = mSNHAPHANG;
	}	
}
