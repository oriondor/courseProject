
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: PVladislav
  Date: 29.05.2018
  Time: 20:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Личный аккаунт</title>
    <link rel="stylesheet" href="source/generalStyle.css">
    <style>
        #bouthEarly tr td img{
            max-height: 100px;
            max-width: 100px;
        }
    </style>
</head>
<body>
<%
    //ПОДКЛЮЧЕНИЕ К БД
    //Connection connect;
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        System.err.println("Driver error!");
    }
    try(Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/databasekursa4","root","root");
        Statement statement = connect.createStatement(); Statement statement2 = connect.createStatement(); Statement statement3 = connect.createStatement()) {
        if(!connect.isClosed()){
            System.out.println("Соединение с БД установлено!");
        }//установлено соединение%>

<%
    String Nickname =null;
    ResultSet userset = null;
    if(session.getAttribute("Nick")!=null) {
        Nickname = session.getAttribute("Nick").toString();
        userset=statement.executeQuery("SELECT * FROM users where nickname='"+Nickname+"';");
        userset.next();}
%>
<!--шапка-->
<table style="width: 100%;">
    <tr id="header">
        <td width="80%"><a href="index.jsp"><h1 style="text-align:center">Web—Shop</h1></a></td>
        <td width="20%" align="right">
            <%if(Nickname!=null){%>
            <a href="user.jsp">
               <%=Nickname%>
            </a>
            <%if(userset.getString("accessLvl").equals("admin")){%>
            <a href="index.html">Add to DB</a>
            <%}%>
            <form action="/LogOutServlet"><input type="submit" value="Log Out"> </form>
            <% }else{
            %>
            <a href="login.html">Log In</a>
            <a href="registration.html">Registration</a>

            <%}
            %>
        </td>
    </tr>
</table>
<%
    String id = userset.getString("user_id");
    ResultSet resultset=statement2.executeQuery("SELECT * FROM orders where user_id="+id+";");
    resultset.next();
    String boughtItems = resultset.getString("items_id");
    String[] eachItem = boughtItems.split(",");
%>
<div>
    Уровень доступа: <%=userset.getString("accessLvl")%>
    <br><br><br>
    Покупали ранее:
    <table id="bouthEarly">
    <%for(Integer i=1;i<eachItem.length;i++){
        System.out.println(eachItem[i]);
    ResultSet itemset = statement3.executeQuery("SELECT * FROM items WHERE item_id="+eachItem[i]+";");
    itemset.next();
    %>
        <tr>
            <td><%=itemset.getString("name")%></td>
        </tr>
        <tr>
            <td><img src="ItemImages/<%=itemset.getString("image")%>"></td>
        </tr>
    <%}%>
    </table>
</div>
<%
        connect.close();//закрытие подключения
    } catch (SQLException e) {
        System.err.println("Неудалось установить подключение!");
    }
%>
</body>
</html>
