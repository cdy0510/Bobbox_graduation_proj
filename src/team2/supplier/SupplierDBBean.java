package team2.supplier;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.supplier.SupplierDataBean;

public class SupplierDBBean {

	private static SupplierDBBean instance = new SupplierDBBean();

	public static SupplierDBBean getInstance() {
		return instance;
	}

	private SupplierDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}
	
	//�⑤벀�믭옙�녾퍥 占쎄퉭以�
	public void insertSupplier(SupplierDataBean supplier) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select max(supplier_num) from supplier");
			rs = pstmt.executeQuery();
			int number = 0;
			if (rs.next()){
				number = rs.getInt(1) + 1;
			}else{ number = 1; }

			sql = "insert into supplier(supplier_name, supplier_man_name, supplier_address, supplier_tel, ";
			sql += "supplier_mail, supplier_bank, supplier_account_data) values(?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, supplier.getSupplier_name());
			pstmt.setString(2, supplier.getSupplier_man_name());
			pstmt.setString(3, supplier.getSupplier_address());
			pstmt.setString(4, supplier.getSupplier_tel());
			pstmt.setString(5, supplier.getSupplier_mail());
			pstmt.setString(6, supplier.getSupplier_bank());
			pstmt.setString(7, supplier.getSupplier_account_data());

			pstmt.executeUpdate();
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
	}

	
	
	//�⑤벀�믭옙�녾퍥 揶쏆뮇��癰귣떯由�
	public int getSupplierCount()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=0;
       try {
           conn = getConnection();
           pstmt = conn.prepareStatement("select count(*) from supplier");
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
	
	//占쎌쥚源�옙占썰빳袁⑹벥 �⑤벀�믭옙�녾퍥 占쎈베��揶쏉옙議뉛옙�븍┛
	public SupplierDataBean findSupplierInfo(int i) 
			throws Exception {
		Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       SupplierDataBean supplier=null;
	       
	       try {
	           conn = getConnection();
	           
	           pstmt = conn.prepareStatement(
	           	"select * from supplier where supplier_num = ?");
	           pstmt.setInt(1, i);
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	        	    supplier = new SupplierDataBean();
					supplier.setSupplier_num(rs.getInt("supplier_num"));
					supplier.setSupplier_name(rs.getString("supplier_name"));
					supplier.setSupplier_man_name(rs.getString("supplier_man_name"));
					supplier.setSupplier_address(rs.getString("supplier_address"));
					supplier.setSupplier_tel(rs.getString("supplier_tel"));
					supplier.setSupplier_mail(rs.getString("supplier_mail"));
					supplier.setSupplier_bank(rs.getString("supplier_bank"));
					supplier.setSupplier_account_data(rs.getString("supplier_account_data"));
				}
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
			return supplier;
	}
			
			
	//�⑤벀�믭옙�녾퍥 筌뤴뫖以�癰귣떯由�
	public List<SupplierDataBean> getSupplierList(int start, int end)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<SupplierDataBean> supplierList=null;
       
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"select * from supplier");
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   supplierList = new ArrayList<SupplierDataBean>(end);
               do{
            	   	SupplierDataBean supplier = new SupplierDataBean();
					supplier.setSupplier_num(rs.getInt("supplier_num"));
					supplier.setSupplier_name(rs.getString("supplier_name"));
					supplier.setSupplier_man_name(rs.getString("supplier_man_name"));
					supplier.setSupplier_address(rs.getString("supplier_address"));
					supplier.setSupplier_tel(rs.getString("supplier_tel"));
					supplier.setSupplier_mail(rs.getString("supplier_mail"));
					supplier.setSupplier_bank(rs.getString("supplier_bank"));
					supplier.setSupplier_account_data(rs.getString("supplier_account_data"));
					supplierList.add(supplier);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return supplierList;
	}
	
	//�⑤벀�믭옙�녾퍥 占쏙옙�ｏ옙�띾┛
	public int deleteSupplier(String selected)
	        throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        int x=-1;

	        try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
				  "DELETE FROM supplier WHERE supplier_num IN("+selected+")");
				pstmt.executeUpdate();
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return x;
	  }	
		
	//�⑤벀�믭옙�녾퍥 占쎈베��占쎌꼷��
	public void updateSupplier(SupplierDataBean supplier) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select * from supplier where supplier_num = ?");
            pstmt.setInt(1, supplier.getSupplier_num());
			rs = pstmt.executeQuery();
			if (rs.next()){
				
            sql = "UPDATE supplier SET supplier_name=?, supplier_man_name=?, supplier_address=?, supplier_tel=?, ";
		    sql+="supplier_mail=?, supplier_bank=?, supplier_account_data=? where supplier_num=?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, supplier.getSupplier_name());
            pstmt.setString(2, supplier.getSupplier_man_name());
            pstmt.setString(3, supplier.getSupplier_address());
            pstmt.setString(4, supplier.getSupplier_tel());
            pstmt.setString(5, supplier.getSupplier_mail());
            pstmt.setString(6, supplier.getSupplier_bank());
            pstmt.setString(7, supplier.getSupplier_account_data());
			pstmt.setInt(8, supplier.getSupplier_num());
			
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
	
	public String getSupplierNameBySupplierNum(int supplierNum) 
			throws Exception {
			Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       String supplierName = "";
	       
	       try {
	           conn = getConnection();
	           
	           pstmt = conn.prepareStatement(
	           	"SELECT supplier_name FROM supplier WHERE supplier_num = ?");
	           pstmt.setInt(1, supplierNum);
	           rs = pstmt.executeQuery();

	           if (rs.next()) {
	        	   supplierName = rs.getString(1);
				}else {
					supplierName = "";
				}
	       } catch(Exception ex) {
	           ex.printStackTrace();
	       } finally {
	           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	       }
			return supplierName;
	}
}
