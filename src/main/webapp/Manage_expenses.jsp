<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<jsp:include page="Manage-expenses.html"></jsp:include>

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
	HttpSession hs  = request.getSession();
	String name  = (String)hs.getAttribute("name");
	String d1 = request.getParameter("date1");
	String d2 = request.getParameter("date2");
	PreparedStatement ps = con.prepareStatement("select e_item,e_date,e_price from expenses_data where e_date between ? and ? and  u_name=?");
	ps.setString(1, d1);
	ps.setString(2, d2);
	ps.setString(3,name);
	ResultSet rs = ps.executeQuery();
	ResultSetMetaData rst = rs.getMetaData();
	int n = rst.getColumnCount(), i = 1;
	if (rs != null) {
%>


	<center>
		<table style="width:35%; padding:0px;margin:0px;" border=2px>
			<tr>
			<%
				while(i<=n)
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
				%>
			</tr>
			
			<%
			while (rs.next())

			{
			%><tr>

				<td><%out.print(rs.getString(1));%></td>
				<td><%out.print(rs.getString(2));%></td>
				<td><%out.print(rs.getString(3));%></td>
				
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