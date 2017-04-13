package team2.room;

import team2.member.MemberDataBean;
import team2.menu.MenuDataBean;

public class RoomDataBean {
	private int room_num;
	private String room1;
	private String room2;
	private String room3;
	private String room4;
	private String room5;
	private String room6;
	private String room7;
	private MenuDataBean menu;
	private MemberDataBean member;
	private String menu_name;
	private String menu_image;
	
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getMenu_image() {
		return menu_image;
	}
	public void setMenu_image(String menu_image) {
		this.menu_image = menu_image;
	}
	public int getRoom_num() {
		return room_num;
	}
	public void setRoom_num(int room_num) {
		this.room_num = room_num;
	}
	public String getRoom1() {
		return room1;
	}
	public void setRoom1(String room1) {
		this.room1 = room1;
	}
	public String getRoom2() {
		return room2;
	}
	public void setRoom2(String room2) {
		this.room2 = room2;
	}
	public String getRoom3() {
		return room3;
	}
	public void setRoom3(String room3) {
		this.room3 = room3;
	}
	public String getRoom4() {
		return room4;
	}
	public void setRoom4(String room4) {
		this.room4 = room4;
	}
	public String getRoom5() {
		return room5;
	}
	public void setRoom5(String room5) {
		this.room5 = room5;
	}
	public String getRoom6() {
		return room6;
	}
	public void setRoom6(String room6) {
		this.room6 = room6;
	}
	public String getRoom7() {
		return room7;
	}
	public void setRoom7(String room7) {
		this.room7 = room7;
	}
	public MenuDataBean getMenu() {
		return menu;
	}
	public void setMenu(MenuDataBean menu) {
		this.menu = menu;
	}
	public MemberDataBean getMember() {
		return member;
	}
	public void setMember(MemberDataBean member) {
		this.member = member;
	}
}
