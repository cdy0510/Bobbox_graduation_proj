<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.menu.MenuDBBean" %>

<% 
	request.setCharacterEncoding("utf-8");
	
	String realFolder="";
	String saveFolder = "../fileSave";
	String encType = "utf-8";
	String filename ="";
	int maxSize = 5*1024*1024;
	ServletContext context = session.getServletContext();
	realFolder = context.getRealPath(saveFolder);  
	out.println("the realpath is : " + realFolder+"<br>");
	MultipartRequest imageUp = null; 
%>
<% try{%>

<%
	imageUp = new MultipartRequest(
		 request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());

    Enumeration files = imageUp.getFileNames();

    while(files.hasMoreElements()){
        String name = (String)files.nextElement();
        filename = imageUp.getFilesystemName(name);
      }
}catch(Exception e){
    e.printStackTrace();
}
%>
 <jsp:useBean id="menu" class="team2.menu.MenuDataBean">
     <jsp:setProperty name="menu" property="*"/>
 </jsp:useBean>

<% 
	String menu_name = imageUp.getParameter("menu_name");
	String menu_charge = imageUp.getParameter("menu_charge");
	String menu_kcal = imageUp.getParameter("menu_kcal");
	String menu_carbor = imageUp.getParameter("menu_carbor");
	String menu_protein = imageUp.getParameter("menu_protein");
	String menu_fat = imageUp.getParameter("menu_fat");
	String menu_natrium = imageUp.getParameter("menu_natrium");
	String menu_big_class = imageUp.getParameter("menu_big_class");
	String menu_small_class = imageUp.getParameter("menu_small_class");
	String supplier_num = imageUp.getParameter("supplier_num");
	String menu_cost = imageUp.getParameter("menu_cost");
	
	menu.setMenu_name(menu_name);
	menu.setMenu_charge(menu_charge);
	menu.setMenu_image(filename);
	menu.setMenu_kcal(Double.parseDouble(menu_kcal));
	menu.setMenu_carbor(Double.parseDouble(menu_carbor));
	menu.setMenu_protein(Double.parseDouble(menu_protein));
	menu.setMenu_fat(Double.parseDouble(menu_fat));
	menu.setMenu_natrium(Double.parseDouble(menu_natrium));
	menu.setMenu_big_class(menu_big_class);
	menu.setMenu_small_class(menu_small_class);
	menu.setSupplier_num(Integer.parseInt(supplier_num));
	menu.setMenu_cost(menu_cost);

	MenuDBBean menuDBPro = MenuDBBean.getInstance();
	menuDBPro.insertMenu(menu);
	response.sendRedirect("AdminMenu.jsp");
%>