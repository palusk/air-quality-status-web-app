package com.ziecinaplaneta.air.controler;

import com.ziecinaplaneta.air.database.Driver;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "Favourite", value = "/Favourite")
public class Favourite extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Driver database = new Driver();

        HttpSession session = request.getSession();

        String[] region = new String[10];
        int x = 0;

         region[0] = request.getParameter("regionF1");
         region[1] = request.getParameter("regionF2");
         region[2] = request.getParameter("regionF3");
         region[3] = request.getParameter("regionF4");
         region[4] = request.getParameter("regionF5");
         region[5] = request.getParameter("regionF6");
         region[6] = request.getParameter("regionF7");
         region[7] = request.getParameter("regionF8");
         region[8] = request.getParameter("regionF9");
         region[9]  = request.getParameter("regionF10");

        String saveF = request.getParameter("saveF");



        if(saveF != null){

            boolean[] tab = new boolean[10];

            for (boolean element : tab) {
                if(region[x] != null){
                    element = true;
                }else element = false;
                x++;
            }

        }
    }
}
