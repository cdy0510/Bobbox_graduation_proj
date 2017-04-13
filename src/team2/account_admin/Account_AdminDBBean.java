package team2.account_admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.admin_board.Admin_BoardDBBean;
import team2.admin_board.Admin_BoardDataBean;

public class Account_AdminDBBean {

	private static Account_AdminDBBean instance = new Account_AdminDBBean();

	public static Account_AdminDBBean getInstance() {
		return instance;
	}

	private Account_AdminDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}
	
	
	/**
	 * 계좌관리 등록하기
	 * @param account_admin
	 * @throws Exception
	 */
	public void insertAccount_Admin(Account_AdminDataBean account_admin)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int number = 0;
		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("SELECT MAX(account_admin_num) FROM account_admin");
			rs = pstmt.executeQuery();

			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			sql = "INSERT INTO account_admin(account_admin_num, bank_name, account_holder, account_num) values(?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, account_admin.getBank_name());
			pstmt.setString(3, account_admin.getAccount_holder());
			pstmt.setString(4, account_admin.getAccount_num());

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

	
	/**
	 * 계좌관리 전체 갯수
	 * @return
	 * @throws Exception
	 */
	public int getAccount_AdminCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from account_admin");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
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
		return x;
	}

	
	
	/**
	 * 계좌목록 조회하기
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<Account_AdminDataBean> getAccount_Admins()
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Account_AdminDataBean> account_adminList = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from account_admin");
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				account_adminList = new ArrayList<Account_AdminDataBean>();
				do {
					Account_AdminDataBean account_admin = new Account_AdminDataBean();
					account_admin
							.setAccount_admin_num(rs.getInt("account_admin_num"));
					account_admin.setBank_name(rs
							.getString("bank_name"));
					account_admin.setAccount_holder(rs
							.getString("account_holder"));
					account_admin.setAccount_num(rs
							.getString("account_num"));

					account_adminList.add(account_admin);
					
				} while (rs.next());
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
		return account_adminList;
	}

	
	/**
	 * 계좌목록 단건조회하기
	 * @param account_admin_num
	 * @return
	 * @throws Exception
	 */
	public Account_AdminDataBean getAccount_Admin(int account_admin_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Account_AdminDataBean account_admin = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select * from account_admin where account_admin_num = ?");
			pstmt.setInt(1, account_admin_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				account_admin = new Account_AdminDataBean();
				account_admin
						.setAccount_admin_num(rs.getInt("account_admin_num"));
				account_admin.setBank_name(rs
						.getString("bank_name"));
				account_admin.setAccount_holder(rs
						.getString("account_holder"));
				account_admin.setAccount_num(rs
						.getString("account_num"));
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
		return account_admin;
	}
	
	
			/**
			 * 은행이름 받아서 계좌번호 출력하기
			 * @param bank_name
			 * @return
			 * @throws Exception
			 */
			public String getAccount_num(String bank_name) throws Exception{
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				String account_num = "";

				try {
					conn = getConnection();

					pstmt = conn.prepareStatement("select account_num from account_admin where bank_name = ?");
					pstmt.setString(1, bank_name);
					rs = pstmt.executeQuery();
					if (rs.next())
						account_num = rs.getString(1);
					else
						account_num = "";
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
				return account_num;
			}

}
