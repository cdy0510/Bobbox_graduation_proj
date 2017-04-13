<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.container.ContainerDBBean"%>
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
		
	

 try{
	imageUp = new MultipartRequest(
		 request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
    Enumeration files = imageUp.getFileNames();

    while(files.hasMoreElements()){
        String name = (String)files.nextElement();
        filename = imageUp.getFilesystemName(name);
      }
	
    String container_num = imageUp.getParameter("container_num");
    String container_image = imageUp.getParameter("container_image");
    String container_detail_image = imageUp.getParameter("container_detail_image");
	String container_name = imageUp.getParameter("container_name");
	String container_price = imageUp.getParameter("container_price");
	String room_count = imageUp.getParameter("room_count");
	%>
	<jsp:useBean id="container" class="team2.container.ContainerDataBean">
    	<jsp:setProperty name="container" property="*"/>
 	</jsp:useBean>
	<%
	container.setContainer_num(Integer.parseInt(container_num));
	container.setContainer_image(container_image);
	container.setContainer_detail_image(container_detail_image);
	container.setContainer_name(container_name);
	container.setContainer_price(container_price);
	container.setRoom_count(Integer.parseInt(room_count));

	       
	ContainerDBBean dbpro = ContainerDBBean.getInstance();
	dbpro.updateContainer(container);
	
	
	response.sendRedirect("AdminContainer.jsp");
 	}catch(Exception e){
	    e.printStackTrace();
	    out.println(e);
	}
%>