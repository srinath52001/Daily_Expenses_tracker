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
int n=Integer.parseInt(request.getParameter("id"));
PreparedStatement ps = con.prepareStatement("delete from daily_expenses where id=?"); 
ps.setInt(1,n);
ps.executeUpdate();
%>
<jsp:forward page="UserList.jsp"/>
</body>
</html>