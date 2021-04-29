package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TitleImageDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public TitleImageDAO() {//DB접속
		try {

			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "c##root";
			String dbPassword = "root";
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

//			 InitialContext ic = new InitialContext();
//			 
//			 DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
//			 
//			 conn = ds.getConnection();
//			

			System.out.println("TitleImageDAO DB연결완료");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}

	public int update(String logid, String imagename) {//프로필사진 업데이트
		String SQL = "update titleimage set imagename=? where logId = ? ";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, imagename);
			pstmt.setString(2, logid);
			pstmt.execute();
			rs = pstmt.executeQuery();

			return 1;//이미지 업데이트가 성공했을때
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;//이미지 업데이트가 실패했을때
	}

	public int insert(String logid, String imagename) {//새로운 아이디에 이미지 삽입
		String SQL = "INSERT INTO titleimage VALUES (?,?)";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logid);
			pstmt.setString(2, imagename);
			pstmt.execute();
			rs = pstmt.executeQuery();
			return 1;//이미지 삽입이 성공했을때

		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;//이미지 삽입이 실패했을때
	}

	public String view(String logid) {//이미지이름 가져오기
		String SQL = "select imagename from titleimage where logid = ?";
		String tatleDefault = "foot.jpg";//기본이미지 생성
		String imagename = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				imagename = rs.getString(1);
			}
			if (imagename == null)
				return tatleDefault;//이미지 삽입실패시 기본이미지
			else
				return imagename;//이미지이름 성공적으로 가져왔을때

		} catch (Exception e) {
			e.printStackTrace();
		}
		return imagename;//이미지 삽입실패시 기본이미지
	}


	
	

	public ArrayList<vo.TitleimageVo> getList(String logId) {//TitleimageVo 정보로 가져오기
		String SQL = "select * from titleimage where logid= ?";
		ArrayList<vo.TitleimageVo> list = new ArrayList<vo.TitleimageVo>();

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.TitleimageVo title = new vo.TitleimageVo();
				title.setLogId(rs.getString(1));
				title.setImagename(rs.getString(2));
				list.add(title);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list; // ArrayList<vo.TitleimageVo>가져오기


	}
	public void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {

		try {
			conn.close();
			pstmt.close();
			rs.close();
		} catch (SQLException e) {
			
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
	public void close() {
		try {
			conn.close();
			pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
