package ptithcm.bean;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;

public class Statistic {
	private String date;
	private int money = 0;
	private int money2 = 0;
	private int profit = 0;
	private int slDH = 0;
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public int getSlDH() {
		return slDH;
	}
	public void setSlDH(int slDH) {
		this.slDH = slDH;
	}
	public int getMoney2() {
		return money2;
	}
	public void setMoney2(int money2) {
		this.money2 = money2;
	}
	public int getProfit() {
		return profit;
	}
	public void setProfit(int profit) {
		this.profit = profit;
	}
	
	
	 
	
}
