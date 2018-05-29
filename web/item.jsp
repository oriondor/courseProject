<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: PVladislav
  Date: 29.05.2018
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Просмотр товара</title>
    <style>
        #Block{
            margin-left:15%;
            margin-top: 5%;
        }
        #ItemName{
            font:bold 60px Helvetica ;
            padding: 30px;
        }
        #ItemMainImage img{
            max-width: 500px;
            max-height: 450px;
        }
        #ItemPrice{
            padding-bottom: 20px;
        }
        #ItemDescr{
            font:30px "Comic Sans MS";
        }
        #ItemImages img{
            max-width:150px;
            max-height: 150px;
        }
    </style>
    <link rel="stylesheet" href="source/generalStyle.css">
</head>
<body>
<!--шапка-->
<table style="width: 100%;">
    <tr id="header">
        <td width="80%"><a href="index.jsp"><h1 style="text-align:center">Web—Shop</h1></a></td>
        <td width="20%" align="right">
            <%if(session.getAttribute("Nick")!=null){%>
            <a href="#">
                <%=session.getAttribute("Nick").toString()%>
            </a>
            <form action="/LogOutServlet"><input type="submit" value="Log Out"> </form>
            <% }else{
            %>
            <a href="login.html">Log In</a>
            <a href="registration.html">Registration</a>
            <a href="index.html">Add to DB</a>
            <%}
            %>
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

<%
    String id = request.getParameter("ItemId");
    ResultSet resultset=statement.executeQuery("SELECT * FROM items where item_id="+id+";");
    resultset.next();
%>
<div id="Block">
<div id="ItemName"><%=resultset.getString("name")%></div>
<div id="ItemMainImage"><img src="ItemImages/<%=resultset.getString("image")%>"></div>
    <div id="ItemPrice"><%=resultset.getString("price")%> грн</div>
<div id="ItemDescr"><%=resultset.getString("description")%></div>
<div id="ItemImages">
    <img src="ItemImages/<%=resultset.getString("additImg")%>">
    <img src="ItemImages/<%=resultset.getString("additImg2")%>">
    <img src="ItemImages/<%=resultset.getString("additImg3")%>">
</div>
</div>


<%
        connect.close();//закрытие подключения
    } catch (SQLException e) {
        System.err.println("Неудалось установить подключение!");
    }
%>
</body>
</html>
