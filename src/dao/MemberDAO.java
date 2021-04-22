package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class MemberDAO {
	
	
	private static MemberDAO dao= new MemberDAO();
	//private MemberDAO();
	public static MemberDAO getInstandce() {
		return dao;
	}
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public MemberDAO() {
		try {

			  String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; 
			  String dbID ="c##root"; 
			  String dbPassword = "root";
			  Class.forName("oracle.jdbc.OracleDriver"); 
			  conn =DriverManager.getConnection(dbURL, dbID, dbPassword);

			
//			 InitialContext ic = new InitialContext();
//			 
//			 DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
//			 
//			 conn = ds.getConnection();
//			

			System.out.println("¿¬°á¿Ï·á");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}

	public int login(String logid, String pwd) {
		String SQL = "select pwd from member where logid=?";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(pwd)) {
					return 1; // ·Î±×ÀÎ ¼º°ø
				} else {
					return 0; // ºñ¹Ð¸ÕÈ£°¡ ´Ù¸¨´Ï´Ù.
				}
			}
			return -1; // ¾ÆÀÌµð°¡ ¾øÀ½ Á¸ÀçÇÏÁö ¾Ê´Â ¾ÆÀÌµð ÀÔ´Ï´Ù.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // µ¥ÀÌÅÍº£ÀÌ½º ¿À·ù
	}

	public int join(vo.MemberVo member) {
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
		return -1; // µ¥ÀÌÅÍº£ÀÌ½º ¿À·ù

	}
	public int modify(vo.MemberVo member) {
		String sql = "update MEMBER set pwd = ?, dogname = ? , email =?, gender =?, age =? where logId = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getDogname());
			pstmt.setString(3, member.getEmail() );
			pstmt.setString(4, member.getGender());
			pstmt.setString(5, member.getAge());
			pstmt.setString(6, member.getLogid());
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		return -1; //ï¿½ï¿½ï¿½ï¿½ï¿½Íºï¿½ï¿½Ì½ï¿½ ï¿½ï¿½ï¿½ï¿½
	}

	public ArrayList<vo.MemberVo> mypage(String logId) {
		// ÇÁ·ÎÇÊ ¸Þ¼Òµå
		String SQL = "select * from member where logid= ? ";
		ArrayList<vo.MemberVo> mypage = new ArrayList<vo.MemberVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.MemberVo membermypage = new vo.MemberVo();
				membermypage.setLogid(rs.getString(1));
				membermypage.setPwd(rs.getString(2));
				membermypage.setDogname(rs.getString(3));
				membermypage.setEmail(rs.getString(4));
				membermypage.setGender(rs.getString(5));
				membermypage.setAge(rs.getString(6));
				mypage.add(membermypage);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mypage;
	}
	
	
	
	public ArrayList<vo.MemberVo> getproFile(String logId) {
		// ÇÁ·ÎÇÊ ¸Þ¼Òµå
		String SQL = "select dogname, age,gender, email  from member where logid= ? ";
		ArrayList<vo.MemberVo> pro = new ArrayList<vo.MemberVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.MemberVo memberpro = new vo.MemberVo();
				memberpro.getDogname();
				memberpro.getAge();
				memberpro.getGender();
				memberpro.getEmail();
				pro.add(memberpro);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return pro;
	}
}
