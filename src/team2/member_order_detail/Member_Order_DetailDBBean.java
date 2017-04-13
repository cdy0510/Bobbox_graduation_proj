package team2.member_order_detail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.menu.MenuDBBean;
import team2.menu.MenuDataBean;
import team2.menu_order_detail.Menu_Order_DetailDataBean;
import team2.menu_ordersheet.Menu_OrderSheetDataBean;

public class Member_Order_DetailDBBean {
	
private static Member_Order_DetailDBBean instance = new Member_Order_DetailDBBean();
	
	public static Member_Order_DetailDBBean getInstance() {
        return instance;
    }
	
	private Member_Order_DetailDBBean(){}
	
	private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/2014a2");
        return ds.getConnection();
    }
	
	
	/**
	 * 회원주문상세 등록하기
	 * @param member_order_detail
	 * @throws Exception
	 */
	public int insertMember_Order_Detail(Member_Order_DetailDataBean member_order_detail) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select max(member_order_detail_num) from member_order_detail");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 

            sql = "insert into member_order_detail(member_order_detail_num, order_quantity, order_delivery_date,"
            		+ "order_delivery_time, order_price, order_where, keep_num, member_order_num) values(?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, number);
            pstmt.setString(2, member_order_detail.getOrder_quantity());
            pstmt.setString(3, member_order_detail.getOrder_delivery_date());
            pstmt.setString(4, member_order_detail.getOrder_delivery_time());
			pstmt.setString(5, member_order_detail.getOrder_price());
            pstmt.setString(6, member_order_detail.getOrder_where());
            pstmt.setInt(7, member_order_detail.getKeep_num());
            pstmt.setInt(8, member_order_detail.getMember_order_num());
           
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
	 * 회원주문상세 갯수
	 * @return
	 * @throws Exception
	 */
	public int getMember_Order_DetailCount()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=0;
       try {
           conn = getConnection();
           pstmt = conn.prepareStatement("select count(*) from member_order_detail");
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
	 * @param memberOrderNum
	 * @return
	 * @throws Exception
	 */
	public List<Member_Order_DetailDataBean> getMemberOrderDetailList() 
			throws Exception {
		Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       List<Member_Order_DetailDataBean> member_order_detailList=null;
	       
	       try {
	           conn = getConnection();
	           
	           pstmt = conn.prepareStatement(
	           	"SELECT m.*, d.*, mem.member_id FROM member_order m, member_order_detail d, keep k, member mem"
	           	+ " WHERE m.member_order_num = d.member_order_num AND d.keep_num = k.keep_num"
	           	+ " AND k.member_num = mem.member_num ORDER BY d.order_delivery_date");
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	        	   member_order_detailList = new ArrayList<Member_Order_DetailDataBean>();
	               do{
	            	    Member_Order_DetailDataBean member_order_detail = new Member_Order_DetailDataBean();
						member_order_detail.setMember_order_detail_num(rs.getInt("member_order_detail_num"));
						member_order_detail.setOrder_quantity(rs.getString("order_quantity"));
						member_order_detail.setOrder_delivery_date(rs.getString("order_delivery_date"));
						member_order_detail.setOrder_delivery_time(rs.getString("order_delivery_time"));
						member_order_detail.setOrder_price(rs.getString("order_price"));
						member_order_detail.setOrder_where(rs.getString("order_where"));
						member_order_detail.setKeep_num(rs.getInt("keep_num"));
						member_order_detail.setMember_id(rs.getString("mem.member_id"));
						member_order_detail.setMember_order_num(rs.getInt("member_order_num"));
						member_order_detail.setMember_pay_date(rs.getString("member_pay_date"));
						member_order_detail.setMember_order_sum_price(rs.getString("member_order_sum_price"));
						member_order_detailList.add(member_order_detail);
				    }while(rs.next());
				}
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
	       return member_order_detailList;
	}

	/**
	 * 회원 주문 단건 조회
	 * @param memberOrderDetailNum
	 * @return
	 * @throws Exception
	 */
	public Member_Order_DetailDataBean getMemberOrderDetail(int memberOrderDetailNum)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Member_Order_DetailDataBean memberOrderDetail = null;
		try {
			conn = getConnection();

			 pstmt = conn.prepareStatement(
			           	"SELECT m.*, d.*, mem.member_id, k.*"
			           	+ " FROM member_order m, member_order_detail d, keep k, member mem"
			           	+ " WHERE m.member_order_num = d.member_order_num"
			           	+ " AND d.keep_num = k.keep_num AND k.member_num = mem.member_num"
			           	+ " AND member_order_detail_num = ?");
			pstmt.setInt(1, memberOrderDetailNum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				memberOrderDetail = new Member_Order_DetailDataBean();
				memberOrderDetail.setMember_order_detail_num(rs.getInt("member_order_detail_num"));
				memberOrderDetail.setKeep_num(rs.getInt("keep_num"));
				memberOrderDetail.setMember_order_num(rs.getInt("member_order_num"));
				memberOrderDetail.setOrder_quantity(rs.getString("order_quantity"));
				memberOrderDetail.setOrder_price(rs.getString("order_price"));
				memberOrderDetail.setOrder_delivery_date(rs.getString("order_delivery_date"));
				memberOrderDetail.setOrder_delivery_time(rs.getString("order_delivery_time"));
				memberOrderDetail.setOrder_where(rs.getString("order_where"));
				memberOrderDetail.setMember_id(rs.getString("member_id"));
				memberOrderDetail.setMember_order_sum_price(rs.getString("member_order_sum_price"));
				memberOrderDetail.setMember_pay_date(rs.getString("member_pay_date"));

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return memberOrderDetail;
	}
	
	/**
	 * 회원의 주문 목록 조회
	 * @param memberId
	 * @return
	 * @throws Exception
	 */
	public List<Member_Order_DetailDataBean> getMemberOrderDetailListByMemberId(String memberId) 
			throws Exception {
		Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       List<Member_Order_DetailDataBean> member_order_detailList=null;
	       
	       try {
	           conn = getConnection();
	           
	           pstmt = conn.prepareStatement(
	           	"SELECT m.*, d.*, mem.member_id FROM member_order m, member_order_detail d, keep k, member mem "
	           	+ " WHERE m.member_order_num = d.member_order_num AND d.keep_num = k.keep_num"
	           	+ " AND k.member_num = mem.member_num AND mem.member_id = ? ORDER BY m.member_pay_date desc");
	           pstmt.setString(1, memberId);
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	        	   member_order_detailList = new ArrayList<Member_Order_DetailDataBean>();
	               do{
	            	    Member_Order_DetailDataBean member_order_detail = new Member_Order_DetailDataBean();
						member_order_detail.setMember_order_detail_num(rs.getInt("member_order_detail_num"));
						member_order_detail.setOrder_quantity(rs.getString("order_quantity"));
						member_order_detail.setOrder_delivery_date(rs.getString("order_delivery_date"));
						member_order_detail.setOrder_delivery_time(rs.getString("order_delivery_time"));
						member_order_detail.setOrder_price(rs.getString("order_price"));
						member_order_detail.setOrder_where(rs.getString("order_where"));
						member_order_detail.setKeep_num(rs.getInt("keep_num"));
						member_order_detail.setMember_id(rs.getString("mem.member_id"));
						member_order_detail.setMember_order_num(rs.getInt("member_order_num"));
						member_order_detail.setMember_pay_date(rs.getString("member_pay_date"));
						member_order_detail.setMember_order_sum_price(rs.getString("member_order_sum_price"));
						member_order_detailList.add(member_order_detail);
				    }while(rs.next());
				}
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
	       return member_order_detailList;
	}
	
}
