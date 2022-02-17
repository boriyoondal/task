package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import Model.ObjDAO;
import Model.ObjVO;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * Servlet implementation class AjaxChart
 */
@WebServlet("/AjaxChart_selectONE")
public class AjaxChart_selectONE extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8");
		String object_id = request.getParameter("object_id");
		
		ObjDAO odao = new ObjDAO();
		ArrayList<ObjVO> oal = odao.obj_one_info(object_id);
		
		Gson gson = new Gson();
		
		response.setCharacterEncoding("utf-8");
		
		PrintWriter out = response.getWriter();
		
		out.print(gson.toJson(oal));
	}

}
