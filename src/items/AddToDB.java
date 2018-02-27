package items;

import com.sun.jdi.event.StepEvent;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(value = "/AddToDB")
public class AddToDB extends HttpServlet {
    private final static String driverName = "com.mysql.jdbc.Driver";
    private final static String URL = "jdbc:mysql://localhost:3306/databasekursa4";
    private final static String USERNAME = "root";
    private final static String PASSWORD = "root";
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        //ПОЛУЧЕНИЕ ПОЛЕЙ
        String N = request.getParameter("ItemName");
        String D = request.getParameter("ItemDescr");
        int P = Integer.parseInt(request.getParameter("ItemPrice"));
        String C = request.getParameter("ItemCategory");
        //ПОДКЛЮЧЕНИЕ К БД
        //Connection connect;
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
                //ДОБАВИТЬ В БАЗУ
            statement.executeUpdate("INSERT into items set name='"+N+"', description='"+D+"', price="+P+", category='"+C+"'");
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html><html><head><title>WebShop Database</title></head><body>");
            out.println("<h3>Элементы были добавлены</h3>");
            out.println("</body></html>");
            /*
            //ПОКАЗАТЬ ВСЕ ЭЛЕМЕНТЫ БАЗЫ
            ResultSet resultset = statement.executeQuery("SELECT * FROM items;");//получение всех элементов
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html><html><head><title>WebShop Database</title></head><body><table>");
            while(resultset.next()){
                out.println("<tr>");
                    out.println("<td>");
                        out.println(resultset.getString("name"));
                    out.println("</td>");
                    out.println("<td>");
                        out.println(resultset.getString("price"));
                        out.println(" Грн");
                    out.println("</td>");
                    out.println("<td>");
                        out.println("Описание:<br>");
                        out.println(resultset.getString("description"));
                    out.println("</td>");
                out.println("</tr>");
            }
            out.println("</table></body></html>");
*/
            connect.close();//закрытие подключения
        } catch (SQLException e) {
            System.err.println("Неудалось установить подключение!");
        }
    }

    /*
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }*/
}
