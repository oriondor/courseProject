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
            margin-top: 2%;
        }
        #Block a{
            color:white;
            text-decoration: none;
            font:bold 25px Helvetica ;
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
            width: 100px;
            text-align: center;
            margin-left: 150px;
            padding: 20px;
            background: greenyellow;
            border-radius: 10px;
        }
        #ItemDescr{
            width: 500px;
            font:20px Calibri;
            padding-bottom: 10px;
        }
        #ItemImages{
            padding-bottom: 60px;
        }
        #ItemImages img{
            max-width:150px;
            max-height: 150px;
        }
        #button{
            width: 110px;
            height: 25px;
            padding: 18px;
            background:#00e229;
            text-align: center;
            border-radius: 10px;
        }
        #button:hover{
            background: #04f730;
        }
    </style>
    <link rel="stylesheet" href="source/generalStyle.css">
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
        Statement statement = connect.createStatement()) {
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
    String id = request.getParameter("ItemId");
    ResultSet resultset=statement.executeQuery("SELECT * FROM items where item_id="+id+";");
    resultset.next();
%>
<div id="Block">
<div id="ItemName"><%=resultset.getString("name")%></div>
<div id="ItemMainImage"><img src="ItemImages/<%=resultset.getString("image")%>"></div>
<div id="ItemPrice"><%=resultset.getString("price")%> грн
    <a href="${pageContext.request.contextPath}/AddToOrders?itemId=<%=id%>"><div id="button">&#8627 Купить</div></a></div>
<div id="ItemDescr"><%=resultset.getString("description")%></div>
    Еще фото:
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
