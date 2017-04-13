package team2.container;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.menu.MenuDataBean;

/**
 * ��� DBBean
 * @author ���ٿ�
 *
 */
public class ContainerDBBean {
private static ContainerDBBean instance = new ContainerDBBean();
	
	public static ContainerDBBean getInstance() {
        return instance;
    }
	
	private ContainerDBBean(){}
	
	private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/2014a2");
        return ds.getConnection();
    }
	
	/**
	 * ��� ���
	 * @param container
	 * @throws Exception
	 */
	public void insertContainer(ContainerDataBean container) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("SELECT MAX(container_num) FROM container");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 

            sql = "insert into container(container_num, container_name, container_price, container_image, ";
		    sql+="container_detail_image, room_count)";
		    sql+="values(?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, number);
            pstmt.setString(2, container.getContainer_name());
            pstmt.setString(3, container.getContainer_price());
            pstmt.setString(4, container.getContainer_image());
            pstmt.setString(5, container.getContainer_detail_image());
            pstmt.setInt(6, container.getRoom_count());
            pstmt.executeUpdate();
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
	
	/**
	 * ��� ���� Count
	 * @return
	 * @throws Exception
	 */
	public int getContainerCount()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=0;
       try {
           conn = getConnection();
           pstmt = conn.prepareStatement("SELECT COUNT(*) FROM container");
           rs = pstmt.executeQuery();

           if (rs.next()) {
              x= rs.getInt(1);
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return x;
   }
	
	/**
	 * ��� ��� ���
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<ContainerDataBean> getContainerList(int start, int end)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<ContainerDataBean> containerList=null;
       
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"SELECT * FROM container");
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   containerList = new ArrayList<ContainerDataBean>(end);
               do{
            	   ContainerDataBean container = new ContainerDataBean();
            	    container.setContainer_num(rs.getInt("container_num"));
            	    container.setContainer_name(rs.getString("container_name"));
            	    container.setContainer_price(rs.getString("container_price"));
            	    container.setContainer_image(rs.getString("container_image"));
            	    container.setContainer_detail_image(rs.getString("container_detail_image"));
            	    container.setRoom_count(rs.getInt("room_count"));
            	    containerList.add(container);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return containerList;
   }
	
	/**
	 * ������ ����ȣ�� ������� ���
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public ContainerDataBean getSelectContainer(int container_num)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       ContainerDataBean container = new ContainerDataBean();
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"SELECT * FROM container where container_num = ?");
           pstmt.setInt(1, container_num);
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	    container.setContainer_num(rs.getInt("container_num"));
        	    container.setContainer_name(rs.getString("container_name"));
        	    container.setContainer_price(rs.getString("container_price"));
        	    container.setContainer_image(rs.getString("container_image"));
        	    container.setContainer_detail_image(rs.getString("container_detail_image"));
        	    container.setRoom_count(rs.getInt("room_count"));
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return container;
   }
	
	/**
	 * ��� ����
	 * @param selected
	 * @return
	 * @throws Exception
	 */
	public int deleteContainer(String selected)
	        throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        int x=-1;

	        try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
				  "DELETE FROM container WHERE container_num IN("+selected+")");
				pstmt.executeUpdate();
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return x;
	  }	
	
		//������ ���� ������� �ҷ�����
		public ContainerDataBean findContainerInfo(int i) 
				throws Exception {
			   Connection conn = null;
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;
		       ContainerDataBean container=null;
		       
		       try {
		           conn = getConnection();
		           
		           pstmt = conn.prepareStatement(
		           	"select * from container where container_num = ?");
		           pstmt.setInt(1, i);
		           rs = pstmt.executeQuery();

		           if (rs.next()) {
		        	   container = new ContainerDataBean();
		        	   container.setContainer_num(rs.getInt("container_num"));
		        	   container.setContainer_name(rs.getString("container_name"));
		        	   container.setContainer_price(rs.getString("container_price"));
		        	   container.setContainer_image(rs.getString("container_image"));
		        	   container.setContainer_detail_image(rs.getString("container_detail_image"));
		        	   container.setRoom_count(rs.getInt("room_count"));
					}
		       } catch(Exception ex) {
		           ex.printStackTrace();
		       } finally {
		           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		       }
				return container;
		}
		
		//��� ����
		public void updateContainer(ContainerDataBean container) 
	            throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
			ResultSet rs = null;
	        String sql="";

	        try {
	            conn = getConnection();

	            pstmt = conn.prepareStatement("select * from container where container_num = ?");
	            pstmt.setInt(1, container.getContainer_num());
				rs = pstmt.executeQuery();
				if (rs.next()){
					
	            sql = "UPDATE container SET container_name=?, container_price=?, container_image=?, container_detail_image=?, room_count=? where container_num=?";

	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, container.getContainer_name());
	            pstmt.setString(2, container.getContainer_price());
	            pstmt.setString(3, container.getContainer_image());
	            pstmt.setString(4, container.getContainer_detail_image());
	            pstmt.setInt(5, container.getRoom_count());
				pstmt.setInt(6, container.getContainer_num());
				
	            pstmt.executeUpdate();
				}
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
				if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
	    }
		
		//������ ���� ĭ���� �ҷ�����
		public int getRoom_count(int i) 
				throws Exception {
			   Connection conn = null;
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;
		       ContainerDataBean container=null;
		       int room_count = 0;
		       
		       try {
		           conn = getConnection();
		           
		           pstmt = conn.prepareStatement(
		           	"select * from container where container_num = ?");
		           pstmt.setInt(1, i);
		           rs = pstmt.executeQuery();
		           
		           if (rs.next()) {
		        	   room_count = rs.getInt("room_count");
					}
		       } catch(Exception ex) {
		           ex.printStackTrace();
		       } finally {
		           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		       }
				return room_count;
		}
		
		
}
