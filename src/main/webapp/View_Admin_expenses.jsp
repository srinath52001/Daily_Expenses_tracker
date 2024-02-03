<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>




<div>
	<h3>Daily Expense Tracker Managemet</h3>
</div>
<div  style="background-color:skyblue;height:30px;">
		<a href="index.html">Home</a>  &nbsp;&nbsp;
	  	<a href="UserList.jsp">User List</a> &nbsp;&nbsp;
	  	<a href="View_Admin_expenses.jsp">View Expenses</a>
	  	<span style="margin-left: 1090px;">Hello,admin</span>&nbsp;&nbsp;
	  	<a href="SignIn.html">Log out</a> 
</div>
<center>
<div>
<h2>Admin Expenses List</h2>
</div>


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
PreparedStatement ps = con.prepareStatement("select * from expenses_data");
	ResultSet rs = ps.executeQuery();
	ResultSetMetaData rst = rs.getMetaData();
	int n = rst.getColumnCount(),i=1;
	if(rs!=null)
		{
%>


	<center>
		<table border=2px>
			<tr>
			<%
				while(i<n)
				{
			%>
			<th>
			<%
				out.print(rst.getColumnName(i));
				i++;
			%>
			</th>
			<%
				}
				%><th>Delete</th>
			</tr>
			
			<%
			while (rs.next())

			{
			%><tr>

				<td><%out.print(rs.getString(1));
				int id = rs.getInt(6);
				%></td>
				<td><%out.print(rs.getString(2));%></td>
				<td><%out.print(rs.getString(3));%></td>
				<td><%out.print(rs.getString(4));%></td>
				<td><%out.print(rs.getString(5));%></td>
				<td>
					 <a href="Delete_admin_Expenses.jsp?id=<%=id%>">delete</a>
				</td>
			</tr>

			<%
			}
			}

			else
			{

			out.println("No data Found");

			}
			%>
		</table>
	</center>





</body>
</html>