<!--
<%@ page import="java.sql.*" %>

  Created by IntelliJ IDEA.
  User: PVladislav
  Date: 27.02.2018
  Time: 19:09
  To change this template use File | Settings | File Templates.
--%>
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Главная</title>
    <style>
        #tovari{
            display: inline;
        }
        .tovar{
            width: 200px;
            height: 200px;
            float: left;
            margin-left: 50px;
            margin-top: 50px;
            border: 1px solid rgba(0, 44, 44, 0.3);
        }
        .tovar:hover{
            border: 1px solid rgba(0, 44, 44, 1);
        }
        .tovarTable tr td{
            width: 200px;
        }

        .tovarTable tr td div{
            width:100px;
            height: 100px;
            margin: auto;
        }
        .tovarTable tr td img{
            max-width:100px;
            max-height: 100px;
            margin:auto;
        }
    </style>
    <link rel="stylesheet" href="source/generalStyle.css">
</head>
<body>


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
<table>
    <form method="get" action="index.jsp">
    <tr>
        <td>
<select name="SortItemCategory">
    <option value="All">All</option>
    <option value="Laptop">Laptop</option>
    <option value="Phone">Phone</option>
    <option value="Printer">Printer</option>
</select>
        </td>
        <td>
    <input type="submit" value="Search">
        </td>
    </tr>
    </form>
</table>

<%
    ResultSet resultset=statement.executeQuery("SELECT * FROM items;");
    if(request.getParameter("SortItemCategory")!=null){
    String cat = request.getParameter("SortItemCategory");
    if(!cat.equals("All")){
    resultset = statement.executeQuery("SELECT * FROM items where category='"+cat+"';");}}//получение всех элементов%>
<br><h3>Доступные товары:</h3>
<div id="tovari">
   <% while(resultset.next()){%>
   <a href="#"> <div class="tovar">
<table class="tovarTable">
    <tr style="border-bottom: 1px solid black;">
        <td>
            <%=resultset.getString("name")%>
        </td>
    </tr>
    <tr>
        <td>
            <div>
            <img src="ItemImages/<%=resultset.getString("image")%>">
            </div>
        </td>
    </tr>
    <tr>
        <td align="right">
            <%=resultset.getString("price")%>
            Грн
        </td>
    </tr>
    <tr>
        <td><input type="button" value="В корзину"></td>
    </tr>
</table>
    </div>
</a>
   <% }%>
</div>
<%
       connect.close();//закрытие подключения
   } catch (SQLException e) {
       System.err.println("Неудалось установить подключение!");
   }
    %>
</body>
</html>
