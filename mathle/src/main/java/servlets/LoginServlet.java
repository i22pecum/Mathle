package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import data.dao.UsuarioDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        if (usuarioDAO.verificarCredenciales(correo, contrasena)) {
            String nombre = usuarioDAO.obtenerNombre(correo);
            HttpSession session = request.getSession();
            session.setAttribute("usuario", nombre);
            session.setAttribute("correo", correo);
            response.sendRedirect("/mathle"); // Redirige al juego si es exitoso
        } else {
            request.setAttribute("error", "Correo o contraseña incorrectos.");
            request.getRequestDispatcher("/mathle/mvc/view/inicioSesion.jsp").forward(request, response);
        }
    }
}
