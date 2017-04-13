package team2.keep;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.delivery.DeliveryDataBean;
import team2.member_order_detail.Member_Order_DetailDataBean;

/**
 * 
 * @author Dayoung
 *
 */
public class KeepDBBean {
	private static KeepDBBean instance = new KeepDBBean();
	
	public static KeepDBBean getInstance() {
        return instance;
    }
	
	private KeepDBBean(){}
	
	private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/2014a2");
        return ds.getConnection();
    }
	
	/**
	 * 담아두기 등록
	 * @param Keep
	 * @throws Exception
	 */
	public void insertKeep(KeepDataBean keep) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("SELECT MAX(keep_num) FROM keep");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 

            sql = "insert into keep(keep_num, save_yes_no, member_num, container_num, ";
		    sql+="menu_num, dosirak_name, dosirak_price)";
		    sql+="values(?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, number);
            pstmt.setString(2, keep.getSave_yes_no());
            pstmt.setInt(3, keep.getMember_num());
            pstmt.setInt(4, keep.getContainer_num());
            pstmt.setString(5, keep.getMenu_num()); 	//배열
            pstmt.setString(6, keep.getDosirak_name());
            pstmt.setString(7, keep.getDosirak_price()); 
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
	 * 담아두기 갯수
	 * @return
	 * @throws Exception
	 */
	public int getKeepCount()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=0;
       try {
           conn = getConnection();
           pstmt = conn.prepareStatement("select count(*) from keep");
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
	 * 장바구니 담긴 갯수
	 * @return
	 * @throws Exception
	 */
	public int getBasketCount()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=0;
       try {
           conn = getConnection();
           pstmt = conn.prepareStatement("select count(*) from keep where save_yes_no=?");
           pstmt.setString(1, "0");
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
	 * 담아두기 목록보기
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<KeepDataBean> getKeepList(int member_num)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<KeepDataBean> keepList=null;
       
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"select * from keep where member_num = ? and save_yes_no = ?");
           pstmt.setInt(1,member_num);
           pstmt.setString(2, "0");
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   keepList = new ArrayList<KeepDataBean>();
               do{
            	   	KeepDataBean keep = new KeepDataBean();
					keep.setKeep_num(rs.getInt("keep_num"));
					keep.setMember_num(rs.getInt("member_num"));
					keep.setContainer_num(rs.getInt("container_num"));
					keep.setMenu_num(rs.getString("menu_num"));
					keep.setSave_yes_no(rs.getString("save_yes_no"));
					keep.setDosirak_name(rs.getString("dosirak_name"));
					keep.setDosirak_price(rs.getString("dosirak_price"));
					keepList.add(keep);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return keepList;
   }
	
	public List<KeepDataBean> getDosirakList(int member_num)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<KeepDataBean> keepList=null;
       
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"select * from keep where member_num = ? and save_yes_no = ?");
           pstmt.setInt(1,member_num);
           pstmt.setString(2, "1");
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   keepList = new ArrayList<KeepDataBean>();
               do{
            	   	KeepDataBean keep = new KeepDataBean();
					keep.setKeep_num(rs.getInt("keep_num"));
					keep.setMember_num(rs.getInt("member_num"));
					keep.setContainer_num(rs.getInt("container_num"));
					keep.setMenu_num(rs.getString("menu_num"));
					keep.setSave_yes_no(rs.getString("save_yes_no"));
					keep.setDosirak_name(rs.getString("dosirak_name"));
					keep.setDosirak_price(rs.getString("dosirak_price"));
					keepList.add(keep);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return keepList;
   }

	/**
	 * 담아두기 번호로 메뉴목록 가져오기
	 * @param keep_num
	 * @return
	 * @throws Exception
	 */
	public String getMenuList(int keep_num)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       String menuList = "";
       
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"select menu_num from keep where keep_num = ?");
           pstmt.setInt(1,keep_num);
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   menuList= rs.getString(1);
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return menuList;
   }
	
	/**
	 * 담아두기 삭제
	 * @param keep_num
	 * @throws Exception
	 */
	public void deleteKeep_num(int keep_num)
	        throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;

	        try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
				  "DELETE FROM keep WHERE keep_num=?");
				pstmt.setInt(1, keep_num);
				pstmt.executeUpdate();
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
	  }

	/**
	 * 저장여부 변경
	 * @param member_num
	 * @throws Exception
	 */
	public void updateSave_yes_no(int member_num)
	        throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;

	        try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
				  "UPDATE keep SET save_yes_no=? WHERE save_yes_no=?");
				pstmt.setString(1, "3");
				pstmt.setString(2, "0");
				pstmt.executeUpdate();
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
	  }
	
	/**
	 * 담아두기 단건 조회
	 * @param keepNum
	 * @return
	 * @throws Exception
	 */
	public KeepDataBean getKeep(int keepNum)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		KeepDataBean keep = null;
		try {
			conn = getConnection();

			 pstmt = conn.prepareStatement(
			           	"SELECT k.*, c.container_name FROM keep k, container c WHERE k.container_num = c.container_num AND keep_num = ?");
			pstmt.setInt(1, keepNum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				keep = new KeepDataBean();
				keep.setKeep_num(rs.getInt("keep_num"));
				keep.setMember_num(rs.getInt("member_num"));
				keep.setContainer_name(rs.getString("container_name"));
				keep.setDosirak_name(rs.getString("dosirak_name"));
				keep.setSave_yes_no(rs.getString("save_yes_no"));
				keep.setDosirak_price(rs.getString("dosirak_price"));
				keep.setMenu_num(rs.getString("menu_num"));
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
		return keep;
	}
	
	/**
	 * 회원의 담아두기 목록 보기
	 * @param memberNum
	 * @return
	 * @throws Exception
	 */
	public List<KeepDataBean> getKeepListByMemberNum(int memberNum)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<KeepDataBean> keepList=null;
       
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"SELECT * FROM delivery d, member_order_detail m, keep k, member mem, member_order mo"
           	+ " WHERE d.member_order_detail_num = m.member_order_detail_num"
           	+ " AND m.keep_num = k.keep_num AND k.member_num = mem.member_num"
           	+ " AND k.member_num = ? ORDER BY mo.member_pay_date desc");
           pstmt.setInt(1, memberNum);
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   keepList = new ArrayList<KeepDataBean>();
               do{
            	   	KeepDataBean keep = new KeepDataBean();
            	   	keep.setKeep_num(rs.getInt("keep_num"));
					keep.setMember_num(rs.getInt("member_num"));
					keep.setContainer_name(rs.getString("container_num"));
					keep.setDosirak_name(rs.getString("dosirak_name"));
					keep.setSave_yes_no(rs.getString("save_yes_no"));
					keep.setDosirak_price(rs.getString("dosirak_price"));
					keep.setMenu_num(rs.getString("menu_num"));
            	   keepList.add(keep);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return keepList;
	}
}
