package team2.cybermoney;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CybermoneyDBBean {

	private static CybermoneyDBBean instance = new CybermoneyDBBean();

	public static CybermoneyDBBean getInstance() {
		return instance;
	}

	private CybermoneyDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}

	/**
	 * 초기 사이버머니 등록하기
	 * 
	 * @param cybermoney
	 * @throws Exception
	 */
	public void insertCybermoney(CybermoneyDataBean cybermoney)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select max(charge_num) from cybermoney");
			rs = pstmt.executeQuery();
						
			int number = 0;
			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			sql = "insert into cybermoney(charge_num, member_num, charge_date, use_date, charge_price,"
					+ "use_bobpul, bobpul) values(?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setInt(2, cybermoney.getMember_num());
			pstmt.setString(3, "");
			pstmt.setString(4, "");
			pstmt.setInt(5, 0);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 0);

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
	
	
	
	public void insertCybermoney2(CybermoneyDataBean cybermoney)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select max(charge_num) from cybermoney");
			rs = pstmt.executeQuery();
						
			int number = 0;
			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			sql = "insert into cybermoney(charge_num, member_num, charge_date, use_date, charge_price,"
					+ "use_bobpul, bobpul) values(?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setInt(2, cybermoney.getMember_num());
			pstmt.setString(3, cybermoney.getCharge_date());
			pstmt.setString(4, "");
			pstmt.setInt(5, cybermoney.getCharge_price());
			pstmt.setInt(6, cybermoney.getUse_bobpul());
			pstmt.setInt(7, cybermoney.getBobpul());

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
	 * 메뉴 주문시 사이버머니 차감
	 * @param cybermoney
	 * @throws Exception
	 */
	public void insertOutput(CybermoneyDataBean cybermoney)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select max(charge_num) from cybermoney");
			rs = pstmt.executeQuery();
						
			int number = 0;
			
			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			sql = "insert into cybermoney(charge_num, member_num, charge_date, use_date, charge_price, use_bobpul, bobpul) values(?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setInt(2, cybermoney.getMember_num());
			pstmt.setString(3, "");
			pstmt.setString(4, cybermoney.getUse_date());
			pstmt.setInt(5, 0);
			pstmt.setInt(6, cybermoney.getUse_bobpul());
			pstmt.setInt(7, 0);

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
	 * 사이버머니 밥풀 갯수
	 * 
	 * @return
	 * @throws Exception
	 */
	public int getCybermoneyCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from cybermoney");
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
	 * 사이버머니 목록 조회하기
	 * 
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<CybermoneyDataBean> getCybermoneys(int start, int end)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CybermoneyDataBean> cybermoneyList = null;
		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select charge_num, m.member_num, charge_date, use_date,"
							+ "charge_price, use_bobpul, member_name, bobpul from cybermoney c, member m where c.member_num=m.member_num");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				cybermoneyList = new ArrayList<CybermoneyDataBean>();
				do {
					CybermoneyDataBean cybermoney = new CybermoneyDataBean();
					cybermoney.setCharge_num(rs.getInt("charge_num"));
					cybermoney.setMember_num(rs.getInt("member_num"));
					cybermoney.setCharge_date(rs.getString("charge_date"));
					cybermoney.setUse_date(rs.getString("use_date"));
					cybermoney.setCharge_price(rs.getInt("charge_price"));
					cybermoney.setUse_bobpul(rs.getInt("use_bobpul"));
					cybermoney.setMember_name(rs.getString("member_name"));
                    cybermoney.setBobpul(rs.getInt("bobpul"));
					
					cybermoneyList.add(cybermoney);
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
		return cybermoneyList;
	}

	
	/**
	 * 사이버머니 단건 조회하기
	 * @param charge_num
	 * @return
	 * @throws Exception
	 */
	public CybermoneyDataBean getCybermoney(int charge_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CybermoneyDataBean cybermoney = null;
		try {
			conn = getConnection();

			
			pstmt = conn
					.prepareStatement("select * from cybermoney where charge_num = ?");
			pstmt.setInt(1, charge_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				cybermoney = new CybermoneyDataBean();
				cybermoney.setCharge_num(rs.getInt("charge_num"));
				cybermoney.setMember_num(rs.getInt("member_num"));
				cybermoney.setCharge_date(rs.getString("charge_date"));
				cybermoney.setUse_date(rs.getString("use_date"));
				cybermoney.setCharge_price(rs.getInt("charge_sum"));
				cybermoney.setUse_bobpul(rs.getInt("use_sum"));
				cybermoney.setMember_name(rs.getString("member_name"));
				cybermoney.setBobpul(rs.getInt("bobpul"));
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
		return cybermoney;

	}
	
	/**
	 * 회원번호로 밥풀 받아오기
	 * @param member_num
	 * @return
	 * @throws Exception
	 */
	public CybermoneyDataBean getBobpul(int member_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		CybermoneyDataBean cybermoney = null;
		

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select sum(bobpul) from cybermoney where member_num = ?");
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if (rs.next()){
				cybermoney = new CybermoneyDataBean();
				cybermoney.setSum_bobpul(rs.getInt("sum(bobpul)"));
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
		return cybermoney;

	}
	
	
	
	/**
	 * 회원번호로 충전금액 가져오기
	 * @param member_num
	 * @return
	 * @throws Exception
	 */
	public CybermoneyDataBean getCharge_price(int member_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		CybermoneyDataBean cybermoney = null;
		

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select sum(charge_price) from cybermoney where member_num = ?");
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if (rs.next()){
				cybermoney = new CybermoneyDataBean();
				cybermoney.setSum_charge_price(rs.getInt("sum(charge_price)"));
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
		return cybermoney;

	}
	
	
	public CybermoneyDataBean getUse_bobpul(int member_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		CybermoneyDataBean cybermoney = null;
		

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select sum(use_bobpul) from cybermoney where member_num = ?");
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if (rs.next()){
				cybermoney = new CybermoneyDataBean();
				cybermoney.setSum_use_bobpul(rs.getInt("sum(use_bobpul)"));
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
		return cybermoney;

	}

	public List<CybermoneyDataBean> getCybermoneyByMemberNum(int member_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<CybermoneyDataBean> cybermoneyList = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("SELECT * FROM cybermoney WHERE member_num = ? ORDER BY charge_num desc");
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cybermoneyList = new ArrayList<CybermoneyDataBean>();
				do {
					CybermoneyDataBean cybermoney = new CybermoneyDataBean();
					cybermoney.setCharge_num(rs.getInt("charge_num"));
					cybermoney.setMember_num(rs.getInt("member_num"));
					cybermoney.setCharge_date(rs.getString("charge_date"));
					cybermoney.setUse_date(rs.getString("use_date"));
					cybermoney.setCharge_price(rs.getInt("charge_price"));
					cybermoney.setUse_bobpul(rs.getInt("use_bobpul"));
                    cybermoney.setBobpul(rs.getInt("bobpul"));
					cybermoneyList.add(cybermoney);
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
		return cybermoneyList;
	}
	
}
