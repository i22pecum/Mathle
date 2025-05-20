package servlets;

import data.dao.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/PersonalizarServlet")
public class PersonalizarServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String color = request.getParameter("color");

        if (color != null && !color.trim().isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("color", color);
        }

        response.sendRedirect("/mathle/");
    }
}