package team2.delivery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.menu_ordersheet.Menu_OrderSheetDataBean;
import team2.supplier.SupplierDataBean;

public class DeliveryDBBean {
	private static DeliveryDBBean instance = new DeliveryDBBean();
	
	public static DeliveryDBBean getInstance() {
		return instance;
	}
	
private DeliveryDBBean(){}
	
	private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/2014a2");
        return ds.getConnection();
    }
	
	
	/**
	 * 회원주문상세 등록하기
	 * @param delivery
	 * @throws Exception
	 */
	public void insertDelivery(DeliveryDataBean delivery) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select max(delivery_num) from delivery");
			rs = pstmt.executeQuery();
			
			if (rs.next()){
		      number=rs.getInt(1)+1;
			}else{
		      number=1; 
			}
            sql = "INSERT INTO delivery(delivery_num, member_order_detail_num, delivery_statement, deliver_message) values(?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, number);
            pstmt.setInt(2, delivery.getMember_order_detail_num());
            pstmt.setString(3, delivery.getDelivery_statement());
			pstmt.setString(4, delivery.getDeliver_message());
           
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
	 * 배송 갯수 조회
	 * @return
	 * @throws Exception
	 */
	public int getDeliveryCount()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=0;
       try {
           conn = getConnection();
           pstmt = conn.prepareStatement("SELECT COUNT(*) FROM delivery");
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
	 * 배송 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<DeliveryDataBean> getDeliveryList()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<DeliveryDataBean> deliveryList=null;
       
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"SELECT * FROM delivery d, member_order_detail m WHERE d.member_order_detail_num = m.member_order_detail_num ORDER BY m.order_delivery_date");
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   deliveryList = new ArrayList<DeliveryDataBean>();
               do{
            	   DeliveryDataBean delivery = new DeliveryDataBean();
            	   delivery.setDelivery_num(rs.getInt("delivery_num"));
            	   delivery.setMember_order_detail_num(rs.getInt("member_order_detail_num"));
            	   delivery.setDeliver_message(rs.getString("deliver_message"));
            	   delivery.setDelivery_statement(rs.getString("delivery_statement"));
            	   deliveryList.add(delivery);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return deliveryList;
	}
	
	/**
	 * 배송 단건 조회
	 * @param deliveryNum
	 * @return
	 * @throws Exception
	 */
	public DeliveryDataBean getDelivery(int memberOrderDetailNum) 
			throws Exception {
		Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       DeliveryDataBean delivery = null;
	       
	       try {
	           conn = getConnection();
	           
	           pstmt = conn.prepareStatement(
	           	"SELECT * FROM delivery WHERE member_order_detail_num = ?");
	           pstmt.setInt(1, memberOrderDetailNum);
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	        	   delivery = new DeliveryDataBean();
            	   delivery.setDelivery_num(rs.getInt("delivery_num"));
            	   delivery.setMember_order_detail_num(rs.getInt("member_order_detail_num"));
            	   delivery.setDeliver_message(rs.getString("deliver_message"));
            	   delivery.setDelivery_statement(rs.getString("delivery_statement"));
	           }
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
	       return delivery;
	}
	
	/**
	 * 상태 업데이트
	 * @param selected
	 * @param statement
	 * @return
	 * @throws Exception
	 */
	public int updateStatement(String selected, String statement)
	        throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        int x=-1;

	        try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
				  "UPDATE delivery SET delivery_statement = ? WHERE delivery_num IN("+selected+")");
				pstmt.setString(1, statement);
				pstmt.executeUpdate();
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return x;
	  }	
}
