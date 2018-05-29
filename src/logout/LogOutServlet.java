package logout;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(value = "/LogOutServlet")
public class LogOutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final static String driverName = "com.mysql.jdbc.Driver";
    private final static String URL = "jdbc:mysql://localhost:3306/databasekursa4?autoReconnect=true&useSSL=false";
    private final static String USERNAME = "root";
    private final static String PASSWORD = "root";
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//ПОДКЛЮЧЕНИЕ К БД
        try {
            Class.forName(driverName);
        } catch (ClassNotFoundException e) {
            System.err.println("Driver error!");
        }
        try(Connection connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
            Statement statement = connect.createStatement()) {
            if(!connect.isClosed()){
                System.out.println("Соединение с БД установлено!");
            }//установлено соединение
            HttpSession session = request.getSession();
            session.setAttribute("Nick",null);
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html><html><head><title>WebShop Login</title></head><body>");
            out.println("<i>You was successfully logged out</i>");
            out.println("<br><a href='index.jsp'>Ok</a>");
            out.println("</body></html>");

            connect.close();//закрытие подключения
        } catch (SQLException e) {
            System.err.println("Неудалось установить подключение!");
        }
    }
}
