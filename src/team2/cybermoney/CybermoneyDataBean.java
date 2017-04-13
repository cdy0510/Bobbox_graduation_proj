package team2.cybermoney;

import team2.member.MemberDataBean;

public class CybermoneyDataBean {

	private int charge_num;
	private MemberDataBean member;
	private String charge_date;
	private String use_date;
	private int charge_price;
	private int use_bobpul;
	private int bobpul;
	private int member_num;
	private String member_name;
	
	private int sum_bobpul;
	private int sum_charge_price;
	private int sum_use_bobpul;
	
	
	
	public int getSum_use_bobpul() {
		return sum_use_bobpul;
	}
	public void setSum_use_bobpul(int sum_use_bobpul) {
		this.sum_use_bobpul = sum_use_bobpul;
	}
	public int getSum_bobpul() {
		return sum_bobpul;
	}
	public void setSum_bobpul(int sum_bobpul) {
		this.sum_bobpul = sum_bobpul;
	}
	public int getSum_charge_price() {
		return sum_charge_price;
	}
	public void setSum_charge_price(int sum_charge_price) {
		this.sum_charge_price = sum_charge_price;
	}
	public int getCharge_num() {
		return charge_num;
	}
	public void setCharge_num(int charge_num) {
		this.charge_num = charge_num;
	}
	public MemberDataBean getMember() {
		return member;
	}
	public void setMember(MemberDataBean member) {
		this.member = member;
	}
	public String getCharge_date() {
		return charge_date;
	}
	public void setCharge_date(String charge_date) {
		this.charge_date = charge_date;
	}
	public String getUse_date() {
		return use_date;
	}
	public void setUse_date(String use_date) {
		this.use_date = use_date;
	}
	public int getCharge_price() {
		return charge_price;
	}
	public void setCharge_price(int charge_price) {
		this.charge_price = charge_price;
	}
	public int getUse_bobpul() {
		return use_bobpul;
	}
	public void setUse_bobpul(int use_bobpul) {
		this.use_bobpul = use_bobpul;
	}
	public int getBobpul() {
		return bobpul;
	}
	public void setBobpul(int bobpul) {
		this.bobpul = bobpul;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	
	
	
	
}
