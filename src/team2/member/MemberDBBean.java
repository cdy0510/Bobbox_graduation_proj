package team2.member;

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
import team2.member.MemberDataBean;

public class MemberDBBean {

	private static MemberDBBean instance = new MemberDBBean();

	public static MemberDBBean getInstance() {
		return instance;
	}

	private MemberDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/2014a2");
		return ds.getConnection();
	}
	
	//회원등록
	public void insertMember(MemberDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select max(member_num) from member");
			rs = pstmt.executeQuery();
			int number = 0;
			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			sql = "insert into member(member_id, member_passwd, member_name, member_gender, member_mail, member_address,";
			sql += "member_tel, member_birth, member_num, member_grade) values(?,?,?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMember_id());
			pstmt.setString(2, member.getMember_passwd());
			pstmt.setString(3, member.getMember_name());
			pstmt.setString(4, member.getMember_gender());
			pstmt.setString(5, member.getMember_mail());
			pstmt.setString(6, member.getMember_address());
			pstmt.setString(7, member.getMember_tel());
			pstmt.setString(8, member.getMember_birth());
			pstmt.setInt(9, number);
			pstmt.setString(10, "Green");

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

	//회원로그인
	public int userCheck(String member_id, String member_passwd)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select member_passwd from member where member_id = ?");
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("member_passwd");
				if (dbpasswd.equals(member_passwd)){
					x = 1;
				}else
					x = 0;
			} else
				x = -1;

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

	//아이디 중복 체크
	public String overlapCheck(String uid) throws Exception {
		String str;
		if (!(uid.equals("admin"))) {
			str = "true";
		} else {
			str = "false";
		}

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbid = "";

		try {
			conn = getConnection();

			pstmt = conn
					.prepareStatement("select member_id from member where member_id = ?");
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbid = rs.getString("member_id");
				if (!(dbid.equals(uid)))
					str = "true";
				else
					str = "false";
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
		return str;
	}
	
	//회원수 보기
	public int getMemberCount()
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int x=0;
       try {
           conn = getConnection();
           pstmt = conn.prepareStatement("select count(*) from member");
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
	
	//선택한 줄의 회원정보 불러오기
			public MemberDataBean findMemberInfo(int i) 
					throws Exception {
				Connection conn = null;
			       PreparedStatement pstmt = null;
			       ResultSet rs = null;
			       MemberDataBean member=null;
			       
			       try {
			           conn = getConnection();
			           
			           pstmt = conn.prepareStatement(
			           	"select * from member where member_num = ?");
			           pstmt.setInt(1, i);
			           rs = pstmt.executeQuery();

			           if (rs.next()) {
			        	    member = new MemberDataBean();
							member.setMember_num(rs.getInt("member_num"));
							member.setMember_name(rs.getString("member_name"));
							member.setMember_id(rs.getString("member_id"));
							member.setMember_passwd(rs.getString("member_passwd"));
							member.setMember_address(rs.getString("member_address"));
							member.setMember_tel(rs.getString("member_tel"));
							member.setMember_mail(rs.getString("member_mail"));
							member.setMember_gender(rs.getString("member_gender"));
							member.setMember_birth(rs.getString("member_birth"));
							member.setMember_grade(rs.getString("member_grade"));
						}
			       } catch(Exception ex) {
			           ex.printStackTrace();
			       } finally {
			           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
			       }
					return member;
			}
			
			
	//회원 목록 보기
	public List<MemberDataBean> getMemberList(int start, int end)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<MemberDataBean> memberList=null;
       
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"select * from member");
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   memberList = new ArrayList<MemberDataBean>(end);
               do{
            	   	MemberDataBean member = new MemberDataBean();
					member.setMember_num(rs.getInt("member_num"));
					member.setMember_name(rs.getString("member_name"));
					member.setMember_id(rs.getString("member_id"));
					member.setMember_passwd(rs.getString("member_passwd"));
					member.setMember_address(rs.getString("member_address"));
					member.setMember_tel(rs.getString("member_tel"));
					member.setMember_mail(rs.getString("member_mail"));
					member.setMember_gender(rs.getString("member_gender"));
					member.setMember_birth(rs.getString("member_birth"));
					member.setMember_order_count(rs.getInt("member_order_count"));
					member.setMember_grade(rs.getString("member_grade"));
					memberList.add(member);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return memberList;
	}
	
	//회원 삭제
	public int deleteMember(String selected)
	        throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        int x=-1;

	        try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
				  "DELETE FROM member WHERE member_num IN("+selected+")");
				pstmt.executeUpdate();
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
			return x;
	  }	
		
	//회원 정보 수정
	public void updateMember(MemberDataBean member) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select * from member where member_num = ?");
            pstmt.setInt(1, member.getMember_num());
			rs = pstmt.executeQuery();
			if (rs.next()){
				
            sql = "UPDATE member SET member_name=?, member_passwd=?, member_address=?, member_tel=?, ";
		    sql+="member_mail=?, member_gender=?, member_grade=?, member_birth=? where member_num=?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, member.getMember_name());
            pstmt.setString(2, member.getMember_passwd());
            pstmt.setString(3, member.getMember_address());
            pstmt.setString(4, member.getMember_tel());
            pstmt.setString(5, member.getMember_mail());
            pstmt.setString(6, member.getMember_gender());
            pstmt.setString(7, member.getMember_grade());
            pstmt.setString(8, member.getMember_birth());
			pstmt.setInt(9, member.getMember_num());
			
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
	
	
	//회원 아이디 받아 회원번호 뿌리기
		public int getMember_num(String member_id) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			int member_num = 0;

			try {
				conn = getConnection();

				pstmt = conn.prepareStatement("select member_num from member where member_id = ?");
				pstmt.setString(1, member_id);
				rs = pstmt.executeQuery();
				if (rs.next())
					member_num = rs.getInt(1);
				else
					member_num = 0;
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
			return member_num;
		}
		
		
		/**
		 * @param member_id
		 * @return
		 * @throws Exception
		 */
		public String getMember_name(String member_id) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String member_name = "";

			try {
				conn = getConnection();

				pstmt = conn.prepareStatement("select member_name from member where member_id = ?");
				pstmt.setString(1, member_id);
				rs = pstmt.executeQuery();
				if (rs.next())
					member_name = rs.getString(1);
				else
					member_name = "";
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
			return member_name;
		}
		
		
		/**
		 * 
		 * @param member_id
		 * @return
		 * @throws Exception
		 */
		public String getMember_grade(String member_id) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String member_grade = "";

			try {
				conn = getConnection();

				pstmt = conn.prepareStatement("select member_grade from member where member_id = ?");
				pstmt.setString(1, member_id);
				rs = pstmt.executeQuery();
				if (rs.next())
					member_grade = rs.getString(1);
				else
					member_grade = "";
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
			return member_grade;
		}
		
		public int getMember_order_count(String member_id) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			int member_order_count = 0;

			try {
				conn = getConnection();

				pstmt = conn.prepareStatement("select member_order_count from member where member_id = ?");
				pstmt.setString(1, member_id);
				rs = pstmt.executeQuery();
				if (rs.next())
					member_order_count = rs.getInt(1);
				else
					member_order_count = 0;
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
			return member_order_count;
		}
		
		/**
		 * 회원 주문횟수 누적
		 * @param member_num
		 * @throws Exception
		 */
		public void updateOrderCount(int member_num) 
	            throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
			ResultSet rs = null;

	        String sql="";

	        try {
	            conn = getConnection();

	            pstmt = conn.prepareStatement("select * from member where member_num = ?");
	            pstmt.setInt(1, member_num);
				rs = pstmt.executeQuery();
				
				if (rs.next()){
		            sql = "UPDATE member SET member_order_count=? WHERE member_num=?";
		            int count = rs.getInt("member_order_count");
		            if(count < 1) {
		            	count = 1;
		            }else {
		            	count += 1;
	            }
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, count);
	            pstmt.setInt(2, member_num);
				
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
	
		public MemberDataBean getMember(String memberId) 
				throws Exception {
			Connection conn = null;
		       PreparedStatement pstmt = null;
		       ResultSet rs = null;
		       MemberDataBean member = null;
		       
		       try {
		           conn = getConnection();
		           
		           pstmt = conn.prepareStatement(
		           	"SELECT * FROM member WHERE member_id = ?");
		           pstmt.setString(1, memberId);
		           rs = pstmt.executeQuery();

		           if (rs.next()) {
		        	    member = new MemberDataBean();
		                member.setMember_num(rs.getInt("member_num"));
						member.setMember_name(rs.getString("member_name"));
						member.setMember_id(rs.getString("member_id"));
						member.setMember_passwd(rs.getString("member_passwd"));
						member.setMember_address(rs.getString("member_address"));
						member.setMember_tel(rs.getString("member_tel"));
						member.setMember_mail(rs.getString("member_mail"));
						member.setMember_gender(rs.getString("member_gender"));
						member.setMember_birth(rs.getString("member_birth"));
						member.setMember_order_count(rs.getInt("member_order_count"));
						member.setMember_grade(rs.getString("member_grade"));
		           }
		       } catch(Exception ex) {
		           ex.printStackTrace();
		       } finally {
		           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		       }
		       return member;
		}
}
