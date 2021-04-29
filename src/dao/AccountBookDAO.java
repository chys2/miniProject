package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AccountBookDAO {
	private Connection conn;
	private ResultSet rs;
	private PreparedStatement pstmt;
	
	public AccountBookDAO() {
		try {
			
			 String dbURL = "jdbc:oracle:thin:@localhost:1521:xe"; 
			  String dbID ="c##root"; 
			  String dbPassword = "root";
			  Class.forName("oracle.jdbc.OracleDriver"); 
			  conn =DriverManager.getConnection(dbURL, dbID, dbPassword);
				
/*
 * InitialContext ic = new InitialContext();
 * 
 * DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");
 * 
 * conn = ds.getConnection();
 */
			 
			System.out.println("AccountBookDAO DB연결완료");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}
	
	
	public int accoumtgetNext() { 
		String SQL = "select accountbookID from accountbook order by accountbookID DESC";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			pstmt.close(); 
			rs.close();
			conn.close();
			return 1; 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	
	public int change_month(String logId, String now_month_startDay,String now_month_endDay) {
		String SQL = "update accountbook set accountbookAvailable=0 "
				+ "where accountbookdate not between to_date(?,'yyyy-mm-dd') and to_date(?,'yyyy-mm-dd') and logid=?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, now_month_startDay);
			pstmt.setString(2, now_month_endDay);
			pstmt.setString(3, logId);
		
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {

			e.printStackTrace();
		}
		return -1; 
	}
	
	public int accountinsert(int accountbookID, String logId, 
			String category, String price, String accountbookdate, int accountbookAvailable) {
		String SQL = "insert into accountbook values(?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),?)";
//insert into accountbook values(4,'test',0,12000,20000,1000,1000,to_date('2021-04-03','yyyy-mm-dd'),1);
// 예제
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, accoumtgetNext());
			pstmt.setString(2, logId);
			if(category.equals("meal")) {
				pstmt.setString(3, price);
				pstmt.setInt(4, 0);
				pstmt.setInt(5, 0);
				pstmt.setInt(6, 0);
				pstmt.setInt(7, 0);
			} else if (category.equals("clothes")) {
				pstmt.setInt(3, 0);
				pstmt.setString(4, price);
				pstmt.setInt(5, 0);
				pstmt.setInt(6, 0);
				pstmt.setInt(7, 0);
			}else if (category.equals("hospital")) {
				pstmt.setInt(3, 0);
				pstmt.setInt(4, 0);
				pstmt.setString(5, price);
				pstmt.setInt(6, 0);
				pstmt.setInt(7, 0);
			}else if (category.equals("hair")) {
				pstmt.setInt(3, 0);
				pstmt.setInt(4, 0);
				pstmt.setInt(5, 0);
				pstmt.setString(6, price);
				pstmt.setInt(7, 0);
			}else if (category.equals("etc")){
				pstmt.setInt(3, 0);
				pstmt.setInt(4, 0);
				pstmt.setInt(5, 0);
				pstmt.setInt(6, 0);
				pstmt.setString(7, price);
			}
			
			pstmt.setString(8,accountbookdate);
			pstmt.setInt(9,1);
		
			return pstmt.executeUpdate();
		} catch (Exception e) {

			e.printStackTrace();
		}
		return -1; 
	}
	
	public ArrayList<vo.AccountBookVo> getAccount(String logId, String now_month_startDay,String now_month_endDay) {
		//이름에 따른 
		String SQL = "select sum(a.meal) as meal, sum(a.clothes) as clothes,  sum(a.hospital)as hospital, sum(a.hair) as hair, sum(a.etc) as etc, m.dogname, sum(a.meal+a.clothes+a.hospital+a.hair+a.etc)as total "
				+ "from accountbook a, member m "
				+ "where a.logid = m.logid and a.logid= ?  "
				+ "and a.accountbookAvailable = 1 and a.accountbookdate between to_date(?,'yyyy-mm-dd') and to_date(?,'yyyy-mm-dd') group by a.logid, m.dogname";
		
		ArrayList<vo.AccountBookVo> list = new ArrayList<vo.AccountBookVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			pstmt.setString(2, now_month_startDay);
			pstmt.setString(3, now_month_endDay);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.AccountBookVo account = new vo.AccountBookVo();
				account.setMeal(rs.getInt(1));
				account.setClothes(rs.getInt(2));
				account.setHospital(rs.getInt(3));
				account.setHair(rs.getInt(4));
				account.setEtc(rs.getInt(5));
				account.setDogname(rs.getString(6));
				account.setTotal(rs.getString(7));
				list.add(account);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 占쏙옙체 占쌉시뱄옙 占쏙옙환
	}

	public ArrayList<vo.AccountBookVo> getSearchAccount(String logId,String beforedate,String afterdate) {
		//이름에 따른 
		String SQL = "select sum(a.meal) as meal, sum(a.clothes) as clothes,  sum(a.hospital)as hospital, sum(a.hair) as hair, sum(a.etc) as etc, m.dogname, sum(a.meal+a.clothes+a.hospital+a.hair+a.etc)as total "
				+ "from accountbook a, member m "
				+ "where a.logid = m.logid and a.logid= ? and a.accountbookdate between to_date(?,'yyyy-mm-dd') and to_date(?,'yyyy-mm-dd')"
				+ "group by a.logid, m.dogname";
		
		ArrayList<vo.AccountBookVo> searchlist = new ArrayList<vo.AccountBookVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			pstmt.setString(2, beforedate);
			pstmt.setString(3, afterdate);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.AccountBookVo account = new vo.AccountBookVo();
				account.setMeal(rs.getInt(1));
				account.setClothes(rs.getInt(2));
				account.setHospital(rs.getInt(3));
				account.setHair(rs.getInt(4));
				account.setEtc(rs.getInt(5));
				account.setDogname(rs.getString(6));
				account.setTotal(rs.getString(7));
				searchlist.add(account);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchlist; // 占쏙옙체 占쌉시뱄옙 占쏙옙환
	}
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
