<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%@ page import="java.sql.*" %>

<%!
Connection con ;
public void init(){
	
	try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con= DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","mydb9am","2505");
	}
	catch(Exception e){
		e.printStackTrace();
	}
}
%>

<%
	String item = request.getParameter("itm");
	String date = request.getParameter("dt");
	String price = request.getParameter("p");
	String des = request.getParameter("des");
	HttpSession hp = request.getSession();
	String uname = (String)hp.getAttribute("name");
	if(item.length()==0||date.length()==0||price.length()==0||des.length()==0||uname.length()==0){
		out.print("Please enter requires fields");
		%><jsp:include page="AddExpenses.html"/><%	
	}
		else
		{
	PreparedStatement ps = con.prepareStatement("insert into expenses_data values(?,?,?,?,?,expenses_database.NEXTVAL) ");
	ps.setString(1,uname);
	ps.setString(2,item);
	ps.setString(3,date);
	ps.setString(4,price);
	ps.setString(5,des);
	ps.executeUpdate();
	out.print("one expense added");
	%><jsp:include page="AddExpenses.html"/><%
		}
%>

</body>
</html>