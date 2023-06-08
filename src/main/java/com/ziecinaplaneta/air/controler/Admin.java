package com.ziecinaplaneta.air.controler;

import com.ziecinaplaneta.air.database.Driver;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "admin", value = "/admin")
public class Admin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Driver database = new Driver();

        String changeId = request.getParameter("changePermission");
        String removeId = request.getParameter("deleteUser");

        if(changeId != null) {
            String dropdownValue = request.getParameter("permissionsDropdown_" + changeId);
            database.changePermisions(Integer.valueOf(changeId), Integer.valueOf(dropdownValue));
            response.sendRedirect("/air_quality_status_web_app2_war_exploded/admin.jsp");
        } else if(removeId != null){
            database.removeUser(Integer.valueOf(removeId));
            response.sendRedirect("/air_quality_status_web_app2_war_exploded/admin.jsp");
        }
    }
}
