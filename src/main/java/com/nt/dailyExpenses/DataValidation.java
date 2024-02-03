package com.nt.dailyExpenses;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/datavalidation")
public class DataValidation extends HttpServlet {

	Connection con;
	ServletContext sc;

	public void init(ServletConfig config) {

		try {
			sc = config.getServletContext();
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "mydb9am", "2505");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter pw = response.getWriter();

		String name = request.getParameter("un");
		String pass = request.getParameter("pw"); 
		try {
			PreparedStatement pst = con.prepareStatement("select * from daily_expenses where f_name=? and password=?");
			pst.setString(1, name);
			pst.setString(2, pass);
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				String roleName = rs.getString("rolename");
				if (roleName.equals("admin")) {
					
					RequestDispatcher rd = request.getRequestDispatcher("admin.html");
					rd.forward(request, response);
//					response.sendRedirect("admin.html");
				} else {
					HttpSession hp = request.getSession();
					hp.setAttribute("name", name);
					RequestDispatcher rd = request.getRequestDispatcher("User.html");
					rd.forward(request, response);
					//response.sendRedirect("User.html");
				}
			} else {
				RequestDispatcher rd = request.getRequestDispatcher("SignIn.html");
				rd.forward(request, response);
				pw.println("Invalid UserName/Password");
//				response.sendRedirect("SignIn.html");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}