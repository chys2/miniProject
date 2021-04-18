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
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public MemberDAO() {
		try {

//			  String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; 
//			  String dbID ="c##root"; 
//			  String dbPassword = "root";
//			  Class.forName("oracle.jdbc.OracleDriver"); 
//			  conn =DriverManager.getConnection(dbURL, dbID, dbPassword);

			
			 InitialContext ic = new InitialContext();
			 
			 DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
			 
			 conn = ds.getConnection();
		

			System.out.println("연결완료");
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
					return 1; // 로그인 성공
				} else {
					return 0; // 비밀먼호가 다릅니다.
				}
			}
			return -1; // 아이디가 없음 존재하지 않는 아이디 입니다.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
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
		return -1; // 데이터베이스 오류

	}

	public ArrayList<vo.MemberVo> getproFile(String logId) {
		// 프로필 메소드
		String SQL = "select dogname, age,gender, email  from member where logid= ? ";
		ArrayList<vo.MemberVo> pro = new ArrayList<vo.MemberVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.MemberVo memberpro = new vo.MemberVo();
				memberpro.setDogname(rs.getString(1));
				memberpro.setAge(rs.getString(2));
				memberpro.setGender(rs.getString(3));
				memberpro.setEmail(rs.getString(4));
				pro.add(memberpro);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return pro;
	}
}
