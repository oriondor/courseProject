<%@ page import="java.sql.*" %>

  Created by IntelliJ IDEA.
  User: PVladislav
  Date: 27.02.2018
  Time: 19:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Работа с БД</title>
    <style>
        a{text-decoration: none;}
    </style>
</head>
<body>
<table style="border:1px solid black;width: 100%;">
    <tr>
        <td width="80%"><a href="index.jsp"><h1 style="text-align:center">_______Welcome to the Web-Shop_______</h1></a></td>
        <td width="20%" align="right">
            <a href="login.html">Log In</a>
            <a href="registration.html">Registration</a>
            <a href="index.html">Add to DB</a>
        </td>
    </tr>
</table>
<%
    //ПОДКЛЮЧЕНИЕ К БД
    //Connection connect;
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        System.err.println("Driver error!");
    }
    try(Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/databasekursa4","root","root");
        Statement statement = connect.createStatement()) {
        if(!connect.isClosed()){
            System.out.println("Соединение с БД установлено!");
        }//установлено соединение%>
<%ResultSet resultset = statement.executeQuery("SELECT * FROM items;");//получение всех элементов%>
<br><br><h3>Доступные товары:</h3>
<table style="border-collapse: collapse;">
   <% while(resultset.next()){%>
    <tr style="border-bottom: 1px solid black;">
        <td style="border-right: 2px solid grey;">
            <%=resultset.getString("name")%>
        </td>

        <td style="border-right: 2px solid grey;">
            Описание:<br>
            <%=resultset.getString("description")%>
        </td>

        <td style="border-right: 2px solid grey;" align="right">
            <%=resultset.getString("price")%>
            Грн
        </td>
    </tr>
   <% }%>
</table>
<%
       connect.close();//закрытие подключения
   } catch (SQLException e) {
       System.err.println("Неудалось установить подключение!");
   }
    %>
</body>
</html>
