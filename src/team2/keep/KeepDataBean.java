package team2.keep;
import team2.member.*;
import team2.menu.*;
import team2.container.*;

public class KeepDataBean {
	private int keep_num;
	private String save_yes_no;
	
	private MemberDataBean member;
	private int member_num;
	
	private ContainerDataBean container;
	private int container_num;
	private String container_name;
	
	private String menu_num;
	private String dosirak_name;
	private String dosirak_price;
	
	
	public int getKeep_num() {
		return keep_num;
	}
	public void setKeep_num(int keep_num) {
		this.keep_num = keep_num;
	}
	public MemberDataBean getMember() {
		return member;
	}
	public void setMember(MemberDataBean member) {
		this.member = member;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public ContainerDataBean getContainer() {
		return container;
	}
	public void setContainer(ContainerDataBean container) {
		this.container = container;
	}
	public String getSave_yes_no() {
		return save_yes_no;
	}
	public void setSave_yes_no(String save_yes_no) {
		this.save_yes_no = save_yes_no;
	}
	public int getContainer_num() {
		return container_num;
	}
	public void setContainer_num(int container_num) {
		this.container_num = container_num;
	}
	public String getMenu_num() {
		return menu_num;
	}
	public void setMenu_num(String menu_num) {
		this.menu_num = menu_num;
	}
	public String getDosirak_name() {
		return dosirak_name;
	}
	public void setDosirak_name(String dosirak_name) {
		this.dosirak_name = dosirak_name;
	}
	public String getDosirak_price() {
		return dosirak_price;
	}
	public void setDosirak_price(String dosirak_price) {
		this.dosirak_price = dosirak_price;
	}
	public String getContainer_name() {
		return container_name;
	}
	public void setContainer_name(String container_name) {
		this.container_name = container_name;
	}
	
}
