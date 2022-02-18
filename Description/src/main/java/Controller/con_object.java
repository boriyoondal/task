package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Model.ObjDAO;
import Model.ObjVO;


@WebServlet("/con_object")
public class con_object extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		
		String camera_id = request.getParameter("camera_id");
		
		ObjDAO odao = new ObjDAO();
		ArrayList<ObjVO> oal = odao.Obj_selectONE(camera_id);
		
		Gson gson = new Gson();
		
		response.setCharacterEncoding("utf-8");
		
		PrintWriter out = response.getWriter();
		
		out.print(gson.toJson(oal));
	}

}
