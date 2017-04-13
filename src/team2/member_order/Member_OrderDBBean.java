package team2.member_order;

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

public class Member_OrderDBBean {
	
private static Member_OrderDBBean instance = new Member_OrderDBBean();
	
	public static Member_OrderDBBean getInstance() {
        return instance;
    }
	
	private Member_OrderDBBean(){}
	
	private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/2014a2");
        return ds.getConnection();
    }
	
	
	/**
	 * 회원 주문서 등록
	 * @param member_order
	 * @throws Exception
	 */
	public int insertMember_Order(Member_OrderDataBean member_order) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("SELECT MAX(member_order_num) FROM member_order");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 

            sql = "INSERT INTO member_order(member_order_num, member_pay_date, member_order_sum_price) VALUES(?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, number);
            pstmt.setTimestamp(2, member_order.getMember_pay_date());
            pstmt.setString(3, member_order.getMember_order_sum_price());
           
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return number;
    }
	
	/**
	 * 회원 주문 갯수 조회
	 * @return
	 * @throws Exception
	 */
	public int getMemberOrderCount()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=0;
       try {
           conn = getConnection();
           pstmt = conn.prepareStatement("SELECT COUNT(*) FROM member_order");
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
	 * 회원주문 목록 조회
	 * @return
	 * @throws Exception
	 */
	public List<Member_OrderDataBean> getMemberOrderList()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<Member_OrderDataBean> memberOrderList=null;
       
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"SELECT * FROM member_order ORDER BY member_order_num desc");
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   memberOrderList = new ArrayList<Member_OrderDataBean>();
               do{
            	   Member_OrderDataBean memberOrder = new Member_OrderDataBean();
            	   memberOrder.setMember_order_num(rs.getInt("member_order_num"));
            	   memberOrder.setMember_order_sum_price(rs.getString("member_order_sum_price"));
            	   memberOrder.setMember_pay_date(rs.getTimestamp("member_pay_date"));
            	   memberOrderList.add(memberOrder);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return memberOrderList;
	}

}
