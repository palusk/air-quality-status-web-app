package com.ziecinaplaneta.air.controler;
import com.ziecinaplaneta.air.database.Driver;
import com.ziecinaplaneta.air.user.Account;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "admin", value = "/admin")
public class Admin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        Driver database = new Driver();

        PrintWriter out = response.getWriter();
        ServletContext context = getServletContext();
        HttpSession session = request.getSession();

        System.out.println("test");

        String changeId = request.getParameter("deleteUser");
        String removeId = request.getParameter("changePermission");

        if(!changeId.isEmpty()) {
            String dropdownValue = request.getParameter("permissionsDropdown_" + changeId);
            database.changePermisions(Integer.valueOf(changeId), Integer.valueOf(dropdownValue));
        } else if(!removeId.isEmpty()){

            database.removeUser(Integer.valueOf(removeId));
        }
    }
}
