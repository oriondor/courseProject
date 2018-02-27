package form;

import com.mysql.fabric.jdbc.FabricMySQLDriver;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import static java.lang.Class.*;

@WebServlet(value = "/LoginFormServlet")
public class LoginFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final static String driverName = "com.mysql.jdbc.Driver";
    private final static String URL = "jdbc:mysql://localhost:3306/databasekursa4?autoReconnect=true&useSSL=false";
    private final static String USERNAME = "root";
    private final static String PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String NN = request.getParameter("NickName");
        String P = request.getParameter("Password");
        Boolean UserFound = false;
        Boolean PassEq = false;
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
            ResultSet resultset = statement.executeQuery("SELECT * FROM users;");
            while(resultset.next()){
                if(NN.equals(resultset.getString("nickname"))){
                    System.out.println(resultset.getString("nickname"));
                    UserFound=true;
                    break;
                }//ПРОВЕРКА НА совпадения в бд
               }
            ResultSet resultset2 = statement.executeQuery("SELECT * from users where nickname='"+NN+"'");
            while(resultset2.next()){
            if(UserFound){
                PassEq = P.equals(resultset2.getString("password"));//проверка паролей
            }
            }

            connect.close();//закрытие подключения
        } catch (SQLException e) {
            System.err.println("Неудалось установить подключение!");
        }

        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html><html><head><title>WebShop Login</title></head><body>");
        if(UserFound && PassEq) {
            HttpSession session = request.getSession();
            session.setAttribute("Nick", request.getParameter("NickName"));//создание сессии, если пользователь подтвержден
            out.println("<h3>You was successfully logged in as "+session.getAttribute("Nick")+"!</h3>");
            out.println("<br><a href='index.html'>Go to main page</a>");
        }else{
            out.println("<h3>No such user found!</h3>");
            out.println("<br><a href='registration.html'>Log On?</a>");
        }
        out.println("</body></html>");
        }


/*
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }*/
}
