package com.ziecinaplaneta.air.controler;
import com.ziecinaplaneta.air.database.Driver;
import com.ziecinaplaneta.air.user.Account;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "login", value = "/login")
public class Login extends HttpServlet {


    public boolean registration(String email, String name, String username, String password, Driver database) {
        if (password.length() >= 8 && !database.checkIfUsernameExist(username)) {
            password = database.hashPassword(password);
            if(database.insertNewUser(email, name, username, password)){
                return true;
            }else return false;
        } else {
            System.out.println("Password is too short (min. 8 characters) or username already exists.");
            return false;
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        Driver database = new Driver();

        PrintWriter out = response.getWriter();
        ServletContext context = getServletContext();
        HttpSession session = request.getSession();


//PARAMETRY
//login
        String username = request.getParameter("username");
        String password = request.getParameter("password");
//rejestracja
        String regname = request.getParameter("regname");
        String regpassword = request.getParameter("regpassword");
        String regusername = request.getParameter("regusername");
        String regemail = request.getParameter("regemail");
//update
        String changename = request.getParameter("changename");


//AKCJE
        String logout = request.getParameter("logout");
        String login = request.getParameter("login");
        String register = request.getParameter("register");
        String save = request.getParameter("save");


        if (login != null) {
            if (!(username == null) && !(password == null)) {
                if (database.validateLogin(username, password)) {
                    Account user = new Account();

                    user.setEmail(database.getEmailByUsername(username));
                    user.setImie(database.getNameByUsername(username));
                    user.setLogin(username);
                    user.setUprawnienia(1);
                    session.setAttribute("user", user);

                    response.sendRedirect("/air_quality_status_web_app2_war_exploded/index.jsp");
                } else {
                    response.sendRedirect("/air_quality_status_web_app2_war_exploded/login.jsp");
                }
            }
        } else if (logout != null) {

            Account emptyUser = new Account();
            emptyUser.setLogin("guest");
            emptyUser.setUprawnienia(0);
            session.setAttribute("user", emptyUser);

            response.sendRedirect("/air_quality_status_web_app2_war_exploded/login.jsp");

        } else if (register != null) {

            if (!regusername.isEmpty() && !regpassword.isEmpty() && !regname.isEmpty() && !regemail.isEmpty()) {
                if(registration(regemail, regname, regusername, regpassword, database)){
                    Account newUser = (Account) session.getAttribute("user");
                    newUser.setImie(regname);
                    newUser.setEmail(regemail);
                    session.setAttribute("user", newUser);
                    newUser.setUprawnienia(1);
                    response.sendRedirect("/air_quality_status_web_app2_war_exploded/index.jsp");
                }else response.sendRedirect("/air_quality_status_web_app2_war_exploded/register.jsp");
            } else response.sendRedirect("/air_quality_status_web_app2_war_exploded/register.jsp");

        } else if (save != null) {

                Account user = (Account) session.getAttribute("user");

                String usernameSave = user.getLogin();
                String regionName = request.getParameter("region");
                int userID = database.getUserId(usernameSave);
                int regionID = database.selectRegionId(regionName);

                if(database.insertIdRegionIntoUsers(regionID, userID)) {
                    response.sendRedirect("/air_quality_status_web_app2_war_exploded/konto.jsp");
                }


                // Account emptyUser = (Account) session.getAttribute("user");
                //emptyUser.setImie(changename);
                //session.setAttribute("user", emptyUser);
               // response.sendRedirect("/air_quality_status_web_app2_war_exploded/index.jsp");


            out.close();
        }
    }
}
