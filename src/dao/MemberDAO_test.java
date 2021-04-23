package dao;

import java.util.ArrayList;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class MemberDAO_test {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private static MemberDAO_test dao = new MemberDAO_test();

	private MemberDAO_test() {
	}

	public static MemberDAO_test getInstance() {
		return dao;
	}

	public Connection getConnection() {
	      String url = "jdbc:oracle:thin:@localhost:1521:xe"; 
	      String dbId = "c##root";    String dbPwd = "root";
	      try {
	         Class.forName("oracle.jdbc.driver.OracleDriver");
	         conn = DriverManager.getConnection(url,dbId,dbPwd);
	         System.out.println("connection");
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return conn;  
	   }//getConnectivity


	public void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {

		try {
			conn.close();
			pstmt.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void close(Connection conn, PreparedStatement pstmt) {
		try {
			conn.close();
			pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public ArrayList<vo.MemberVo> selectMemberAll() {
		String SQL = "select *  from member";
		ArrayList<vo.MemberVo> member = new ArrayList<vo.MemberVo>();
		try {
//			InitialContext ic = new InitialContext();
//
//			DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
//
//			Connection conn = ds.getConnection();

			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			System.out.println("test2");

			rs = pstmt.executeQuery();
			while (rs.next()) {
				member.add(new vo.MemberVo(rs.getString("logid"), rs.getString("pwd"), rs.getString("dogname"),
						rs.getString("email"), rs.getString("gender"), rs.getString("age")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		return member;
	}

	public vo.MemberVo selectMember(String userId) {
		String SQL = "select *  from member where logId =? ";
		vo.MemberVo member = new vo.MemberVo();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				member.setLogid(rs.getString("logId"));
				member.setPwd(rs.getString("Pwd"));
				member.setDogname(rs.getString("dogname"));
				member.setEmail(rs.getString("email"));
				member.setGender(rs.getString("gender"));
				member.setAge(rs.getString("age"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return member;
	}

//	public static MemberDTO selectMember(String userId) {
//		MemberDTO dto = new MemberDTO();
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		String sql = "select * from Members where userid=?";
//		
//		try {
//			conn = getConnection();
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, userId);
//			rs = pstmt.executeQuery();
//			
//			if(rs.next()) {
//				dto.setUserId(rs.getString("userId"));
//				dto.setUserPwd(rs.getString("userPwd"));
//				dto.setUserName(rs.getString("userName"));
//				dto.setPhoneNo(rs.getString("phoneNo"));
//				dto.setAddress(rs.getString("address"));
//				dto.setEmail(rs.getString("email"));
//			}
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//		return dto;
//	}

	public int insertMember(vo.MemberVo member) {
		String SQL = "INSERT INTO MEMBER VALUES (?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, member.getLogid());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getDogname());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getGender());
			pstmt.setString(6, member.getAge());
			return pstmt.executeUpdate();
		}

		catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류

	}

	public int updatetMember(vo.MemberVo member) {
		String sql = "update MEMBER set pwd = ?, dogname = ? , email =?, gender =?, age =? where logId = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getDogname());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getGender());
			pstmt.setString(5, member.getAge());
			pstmt.setString(6, member.getLogid());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		return -1;
	}

	public int deleteMember(vo.MemberVo member) {
		String sql = "delete MEMBER  where logId = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getLogid());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		return -1;
	}
}
