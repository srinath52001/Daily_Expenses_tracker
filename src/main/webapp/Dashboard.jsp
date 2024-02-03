<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<style>
.d {
	width: 300px;
	height: 150px;
	border: 2px solid black;
	padding: 20px;
	text-align: center;
}

#c {
	display: grid;
	grid-template-columns: auto auto;
	padding: 50px 300px;
	row-gap: 50px;
}
</style>
</head>
<body>

	<div>
		<h3>Daily Expense Tracker Managemet</h3>
	</div>
	<div style="background-color: skyblue; height: 30px;">
		<a href="index.html">Home</a>  &nbsp;&nbsp;
	  	<a href="Dashboard.jsp">Dash Board</a> &nbsp;&nbsp;
	    <a href="AddExpenses.html">Add Expenses</a> &nbsp;&nbsp;
	  	<a href="ViewExpenses.jsp">View Expenses</a>&nbsp;&nbsp;
	  	<a href="Manage-expenses.html">Manage Expenses</a> 
	  	<span style="padding-left:60%;">Hello</span>&nbsp;&nbsp;
	  	<a href="SignIn.html">Log out</a> 
	</div>
	<%@page import="java.sql.*" %>
	<%!
Connection con ;
	
	PreparedStatement pst ; 
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
	<div id="c">
		<div class="d">
			<div>TODAY EXPENSES</div><br><br>
			<div>
			<%
		HttpSession hs = request.getSession();
		String name = (String) hs.getAttribute("name");
		pst = con.prepareStatement("select sum(e_price) from expenses_data where e_date=to_char(sysdate,'yyyy-mm-dd') and u_name=?");
		pst.setString(1, name);
		ResultSet rs = pst.executeQuery();
		if (rs.next())
		{
			if (!(rs.getString(1) == null))
				out.println(rs.getString(1));
			else
			{
				out.println("0");
			}
		}
		%></div>
		</div>
		<div class="d">
		<div>YESTERDAY'S EXPENSES</div><br><br>
		<div>
			<%
		pst = con.prepareStatement("select sum(e_price) from expenses_data where e_date=to_char(sysdate-7,'yyyy-mm-dd') and u_name=?");
		pst.setString(1, name);
		ResultSet rs1 = pst.executeQuery();
		if (rs1.next())
		{
			if (!(rs1.getString(1) == null))
				out.println(rs1.getString(1));
			else
			{
				out.println("0");
			}
		}
		%></div>
		</div>
		<div class="d">
		<div>LAST 7 DAYS'S EXPENSES</div><br><br>
		<div>
			<%
		pst = con.prepareStatement("select sum(e_price) from expenses_data where e_date between to_char(sysdate-7,'yyyy-mm-dd') and  to_char(sysdate,'yyyy-mm-dd') and u_name=?");
		pst.setString(1, name);
		ResultSet rs2 = pst.executeQuery();
		if (rs2.next())
		{
			if (!(rs2.getString(1) == null))
				out.println(rs2.getString(1));
			else
			{
				out.println("0");
			}
		}
		%></div>
		</div>
		
		<div class="d">
		<div>CURRENT YEAR EXPENSES</div><br><br>
		<div>
			<%
		pst = con.prepareStatement("select sum(e_price) from expenses_data where e_date between to_char(sysdate-365,'yyyy-mm-dd') and to_char(sysdate,'yyyy-mm-dd') and u_name=?");
		pst.setString(1, name);
		ResultSet rs3 = pst.executeQuery();
		if (rs3.next())
		{
			if (!(rs3.getString(1) == null))
				out.println(rs3.getString(1));
			else
			{
				out.println("0");
			}
		}
		%></div>
		
		</div>
		<div class="d">
		<div>TOTAL EXPENSES</div><br><br>
		<div>
			<%
		pst = con.prepareStatement("select sum(e_price) from expenses_data where u_name=?");
		pst.setString(1, name);
		ResultSet rs4 = pst.executeQuery();
		if (rs4.next())
		{
			if (!(rs4.getString(1) == null))
				out.println(rs4.getString(1));
			else
			{
				out.println("0");
			}
		}
		%></div>
		</div>
	</div>

</body>
</html>