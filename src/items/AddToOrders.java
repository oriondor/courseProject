package items;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(value = "/AddToOrders")
public class AddToOrders extends HttpServlet {
    private final static String driverName = "com.mysql.jdbc.Driver";
    private final static String URL = "jdbc:mysql://localhost:3306/databasekursa4";
    private final static String USERNAME = "root";
    private final static String PASSWORD = "root";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");


        //ПОДКЛЮЧЕНИЕ К БД
        //Connection connect;
        try {
            Class.forName(driverName);
        } catch (ClassNotFoundException e) {
            System.err.println("Driver error!");
        }
        try(Connection connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
            Statement statement = connect.createStatement();
            Statement statement2 = connect.createStatement()) {
            if(!connect.isClosed()){
                System.out.println("Соединение с БД установлено!!");
            }//установлено соединение
            HttpSession session = request.getSession();
            String login = session.getAttribute("Nick").toString();
            System.out.println(login);
            Integer itemId = Integer.parseInt(request.getParameter("itemId"));
            System.out.println(itemId);
            //ИЗВЛЕЧЬ ИЗ БАЗЫ
            ResultSet userset = statement.executeQuery("SELECT * FROM  users WHERE nickname='"+login+"';");
            userset.next();
            Integer id = Integer.parseInt(userset.getString("user_id"));
            System.out.println(id);
            ResultSet itemset = statement2.executeQuery("SELECT * FROM orders WHERE user_id="+id+";");
            itemset.next();
            String Items = itemset.getString("items_id");
            System.out.println(Items);
                Items+=","+itemId;
            System.out.println(Items);
            //ДОБАВИТЬ В БАЗУ
            statement.executeUpdate("UPDATE orders set items_id='"+Items+"' where user_id="+id+";");

            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html><html><head><title>WebShop Buy</title></head><body>");
            out.println("<h3>Вы купили товар!</h3>");
            out.println("</body></html>");

            connect.close();//закрытие подключения
        } catch (SQLException e) {
            System.err.println("Неудалось установить подключение!");
        }
    }
    }

