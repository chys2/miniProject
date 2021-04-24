package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class AccountBookDAO {
	private Connection conn;
	private ResultSet rs;

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
			 
			System.out.println("연결완료2");

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
			return 1; 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	
	public int accountinsert(int accountbookID, String logId, 
			int meal, int clothes,int hospital,int hair,int etc, String accountbookdate, int accountbookAvailable) {
		String SQL = "insert into accountbook values(?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),?)";
//insert into accountbook values(4,'test',0,12000,20000,1000,1000,to_date('2021-04-03','yyyy-mm-dd'),1);
// 예제
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, accoumtgetNext());
			pstmt.setString(2, logId);
			pstmt.setInt(3,meal);
			pstmt.setInt(4,clothes);
			pstmt.setInt(5,hospital);
			pstmt.setInt(6,hair);
			pstmt.setInt(7,etc);
			pstmt.setString(8,accountbookdate);
			pstmt.setInt(9,1);
		
			return pstmt.executeUpdate();
		} catch (Exception e) {

			e.printStackTrace();
		}
		return -1; 
	}
	
	public ArrayList<vo.AccountBookVo> getAccount(String logId) {
		//이름에 따른 
		String SQL = "select sum(a.meal) as meal, sum(a.clothes) as clothes,  sum(a.hospital)as hospital, sum(a.hair) as hair, sum(a.etc) as etc, m.dogname from accountbook a, member m where a.logid = m.logid and a.logid= ?  and a.accountbookAvailable = 1 group by a.logid, m.dogname";
		
		ArrayList<vo.AccountBookVo> list = new ArrayList<vo.AccountBookVo>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, logId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.AccountBookVo account = new vo.AccountBookVo();
				account.setMeal(rs.getInt(1));
				account.setClothes(rs.getInt(2));
				account.setHospital(rs.getInt(3));
				account.setHair(rs.getInt(4));
				account.setEtc(rs.getInt(5));
				account.setDogname(rs.getString(6));
				list.add(account);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 占쏙옙체 占쌉시뱄옙 占쏙옙환
	}


}
