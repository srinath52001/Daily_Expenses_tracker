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
	<div style="background-color: skyblue; height: 30px;">
		<a href="index.html">Home</a> &nbsp;&nbsp; <a href="Dashboard.jsp">Dash
			Board</a> &nbsp;&nbsp; <a href="AddExpenses.html">Add Expenses</a>
		&nbsp;&nbsp; <a href="ViewExpenses.jsp">View Expenses</a>&nbsp;&nbsp;
		<a href="Manage-expenses.html">Manage Expenses</a> <span
			style="padding-left: 60%;">Hello</span>&nbsp;&nbsp; <a
			href="SignIn.html">Log out</a>
	</div>
	<center>
		<div>
			<h2>Expenses List</h2>
		</div>

		<%@ page import="java.sql.*"%>

		<%!Connection con;

	public void init() {

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "mydb9am", "2505");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}%>

		<%
		HttpSession hs = request.getSession();
		String name = (String) hs.getAttribute("name");
		PreparedStatement ps = con.prepareStatement("select * from expenses_data where u_name=?");
		ps.setString(1, name);
		ResultSet rs = ps.executeQuery();
		ResultSetMetaData rst = rs.getMetaData();
		int n = rst.getColumnCount(), i = 1;
		if (rs != null) {
		%>
		<center>
			<table border=2px>
				<tr>
					<%
					while (i < n) {
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

					<td>
						<%
						out.print(rs.getString(1));
						int id = rs.getInt(6);
						%>
					</td>
					<td>
						<%
						out.print(rs.getString(2));
						%>
					</td>
					<td>
						<%
						out.print(rs.getString(3));
						%>
					</td>
					<td>
						<%
						out.print(rs.getString(4));
						%>
					</td>
					<td>
						<%
						out.print(rs.getString(5));
						%>
					</td>
					<td><a href="DeleteRow1.jsp?id=<%=id%>">delete</a></td>
				</tr>

				<%
				}
				}

				else {

				out.println("No data Found");

				}
				%>
			</table>
		</center>



	</center>
</body>
</html>