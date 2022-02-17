package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ObjDAO {
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ObjVO vo = null;
	int cnt = 0;
	ArrayList<ObjVO> al = null;
	
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
	
	//Object List 출력하는 ArrayList
	public ArrayList<ObjVO> bioObjList() {
		
		try {

			al = new ArrayList<ObjVO>();

			connection();

			String sql = "select distinct object_id from IntFlow ";

			psmt = conn.prepareStatement(sql);

			rs = psmt.executeQuery();

			while (rs.next()) {
				
				String getObject_id = rs.getString("object_id");

				vo = new ObjVO(getObject_id);


//	   	            vo값을 al에 add

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
	
	
	public ArrayList<ObjVO> obj_info(String object_id) {
		ObjVO vo = null;
		ArrayList<ObjVO> oal = new ArrayList<ObjVO>();
		try {
			connection();

			String sql = "select drinking,feed,activity from IntFlow where object_id = ?";
			
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, object_id);

			rs = psmt.executeQuery();

			while (rs.next()) {

				String getObject_id = rs.getString("object_id");
				String getDrinking = rs.getString("drinking");
				String getFeed = rs.getString("feed");
				String getActivity = rs.getString("activity");

				vo = new ObjVO(getObject_id,getDrinking,getFeed,getActivity);
				oal.add(vo);
			}

		} catch (Exception e) {
			System.out.println("조회실패");
			e.printStackTrace();

		} finally {
			close();
		}
		return oal;
	}
	
	public ArrayList<ObjVO> obj_info() {
		ObjVO vo = null;
		ArrayList<ObjVO> oal = new ArrayList<ObjVO>();
		try {
			connection();

			String sql = "select drinking,feed,activity from IntFlow";
			
			psmt = conn.prepareStatement(sql);

			rs = psmt.executeQuery();

			while (rs.next()) {

				String getDrinking = rs.getString("drinking");
				String getFeed = rs.getString("feed");
				String getActivity = rs.getString("activity");

				vo = new ObjVO(getDrinking,getFeed,getActivity);
				oal.add(vo);
			}

		} catch (Exception e) {
			System.out.println("조회실패");
			e.printStackTrace();

		} finally {
			close();
		}
		return oal;
	}
	
	public ObjVO Obj_selectONE(String Object_id) {

		try {
			connection();

			String sql = "select Object_id from IntFlow";
			
			psmt = conn.prepareStatement(sql);
			
			rs = psmt.executeQuery();

			while (rs.next()) {

				String getObject_id = rs.getString("Object_id");


				vo = new ObjVO(Object_id);

			}

		} catch (Exception e) {
			System.out.println("조회실패");
			e.printStackTrace();

		} finally {
			close();
		}
		return vo;
	}
}
