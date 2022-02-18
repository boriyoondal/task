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
	
	
	public ArrayList<ObjVO> obj_info() {
	      ObjVO vo = null;
	      ArrayList<ObjVO> oal = new ArrayList<ObjVO>();
	      try {
	         connection();

	         String sql = "select current_dt,avg(drinking) drinking,avg(feed) feed,avg(activity) activity from IntFlow group by current_dt";
	         psmt = conn.prepareStatement(sql);

	         rs = psmt.executeQuery();

	         while (rs.next()) {
	            String getcurrent_dt = rs.getString("current_dt");
	            String getDrinking = rs.getString("drinking");
	            String getFeed = rs.getString("feed");
	            String getActivity = rs.getString("activity");

	            vo = new ObjVO(getcurrent_dt,getDrinking,getFeed,getActivity);
	            oal.add(vo);
	         }

	      } catch (Exception e) {
	         System.out.println("SQL 통과 실패");
	         e.printStackTrace();

	      } finally {
	         close();
	      }
	      return oal;
	   }
	
	public ArrayList<ObjVO> obj_one_info(String object_id) {
	      ObjVO vo = null;
	      ArrayList<ObjVO> oal = new ArrayList<ObjVO>();
	      try {
	         connection();

	         String sql = "select current_dt, drinking, feed, activity from IntFlow where object_id=? order by current_dt asc";
	         psmt = conn.prepareStatement(sql);
	         psmt.setString(1, object_id);
	         rs = psmt.executeQuery();

	         while (rs.next()) {
	            String getcurrent_dt = rs.getString("current_dt");
	            String getDrinking = rs.getString("drinking");
	            String getFeed = rs.getString("feed");
	            String getActivity = rs.getString("activity");

	            vo = new ObjVO(getcurrent_dt,getDrinking,getFeed,getActivity);
	            oal.add(vo);
	         }

	      } catch (Exception e) {
	         System.out.println("SQL 통과 실패");
	         e.printStackTrace();

	      } finally {
	         close();
	      }
	      return oal;
	   }
	
	public ArrayList<ObjVO> Obj_selectONE(String camera_id) {
		  ObjVO vo = null;
	      ArrayList<ObjVO> oal = new ArrayList<ObjVO>();
		try {
			connection();

			String sql = "select distinct object_id from IntFlow where camera_id=?";
			
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, camera_id);
			
			rs = psmt.executeQuery();

			while (rs.next()) {

				String getCamera_id= rs.getString("camera_id");
				String getObject_id = rs.getString("object_id");


				vo = new ObjVO(getCamera_id,getObject_id);
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
}
