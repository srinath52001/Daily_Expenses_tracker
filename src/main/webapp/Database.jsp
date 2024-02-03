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

String fname=request.getParameter("fn");
String lname=request.getParameter("ln");
String mail=request.getParameter("em");
String pass=request.getParameter("pw");
String ph=request.getParameter("ph");
if(fname.length()==0||lname.length()==0||mail.length()==0||pass.length()==0||ph.length()==0){
	out.print("Please enter requires fields");
	%><jsp:include page="signup.html"/>	<%	
}
	else
	{

PreparedStatement ps = con.prepareStatement("insert into daily_expenses values(?,?,?,?,?,?,daily_seq.NEXTVAL)");


ps.setString(1,fname);
ps.setString(2,lname);
ps.setString(3,mail);
ps.setString(4,pass);
ps.setString(5,ph);
ps.setString(6,"User");
ps.executeUpdate();
%>

<jsp:include page="signup.html"/>
<% } %>
</body>
</html>