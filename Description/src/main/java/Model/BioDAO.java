package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


//DB 연결을 위한 DAO 
public class BioDAO {

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	BioVO vo = null;
	int cnt = 0;
	ArrayList<BioVO> al = null;
	
	public void connection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	         String url="jdbc:mysql://localhost:3307/IntFlow";
	         String dbid="root";
	         String dbpw="root";

			System.out.println("DB 접속 성공");
			conn = DriverManager.getConnection(url, dbid, dbpw);

		} catch (Exception e) {
			System.out.println("DB 접속 실패");
			e.printStackTrace();
		}
	}
	

	//사용한 자원 닫아주기 
	public void close() {
		try {
			if (rs != null) {
				rs.close();
			}
			if (psmt != null) {
				psmt.close();
			}
			if (conn != null) {
				conn.close();
			}

		} catch (Exception e2) {
			e2.printStackTrace();
		}

	}
	
	//Camera 순번 뽑아내주는 ArrayList 
	public ArrayList<BioVO> bioCamList() {
		
	try {

		al = new ArrayList<BioVO>();

		connection();

		String sql = "select distinct camera_id from IntFlow";

		psmt = conn.prepareStatement(sql);

		rs = psmt.executeQuery();

		while (rs.next()) {
			
			String getCamera_id = rs.getString("camera_id");
			
			vo = new BioVO(getCamera_id);

			al.add(vo);

		}

	} catch (Exception e) {
		System.out.println("조회실패");
		e.printStackTrace();

	} finally {
		close();
	}
	return al;
	}	
	

}
