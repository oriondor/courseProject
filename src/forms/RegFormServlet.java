package forms;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(value = "/RegFormServlet")
public class RegFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final static String URL = "jdbc:mysql://localhost:3306/databasekursa4";
    private final static String USERNAME = "root";
    private final static String PASSWORD = "root";
    /*protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }*/

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=utf-8");

        //ПЕРЕМЕННЫЕ ПРОВЕРКИ
        Boolean UserExist = false;
        //поиск одинаковых юзернеймов

        //ПОЛУЧЕНИЕ ДАННЫХ ИЗ ЗАПРОСА
        String NN = request.getParameter("NickName");
        String FN = request.getParameter("FirstName");
        String LN = request.getParameter("LastName");
        String M = request.getParameter("Mail");
        String P = request.getParameter("Password");

        //ПОДКЛЮЧЕНИЕ К БД
        //Connection connect;
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Driver error!");
        }
        try(Connection connect = DriverManager.getConnection(URL,USERNAME,PASSWORD);
            Statement statement = connect.createStatement()) {
            if(!connect.isClosed()){
                System.out.println("Соединение с БД установлено!");
            }//установлено соединение
                ResultSet resultset = statement.executeQuery("SELECT * FROM users;");
            while(resultset.next()){
                if(NN.equals(resultset.getString("nickname"))){UserExist=true;}//ПРОВЕРКА НА ОДИНАКОВЫЕ НИКНЕЙМЫ
            }
            if(!UserExist)//Записать данные в базу, если пользователь ещё не был создан
                statement.executeUpdate("INSERT into users set nickname='"+NN+"', name='"+FN+"', surname='"+LN+"', email='"+M+"', password = '"+P+"'");

            connect.close();//закрытие подключения
        } catch (SQLException e) {
            System.err.println("Неудалось установить подключение!");
        }

        //System.out.println("User exist-> "+UserExist);
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html><html><head><title>WebShop Log on</title></head><body>");
           if(!UserExist){
            out.print("<h3>You was successfully registered as "+NN+"!</h3>");
        }else{
            out.println("<h3>Try using different nickname. Nickname <i>"+NN+"</i> is already in use :(</h3>");
           }
        out.println("</body></html>");
    }
}
