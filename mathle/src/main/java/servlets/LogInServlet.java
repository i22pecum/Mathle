import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("correo");
        String contraseña = request.getParameter("contrasena");

        if (usuarioDAO.verificarCredenciales(email, contraseña)) {
            String nombre = usuarioDAO.obtenerNombre(email);
            HttpSession session = request.getSession();
            session.setAttribute("usuario", nombre);
            session.setAttribute("email", email);
            response.sendRedirect("juego.jsp"); // Redirige al juego si es exitoso
        } else {
            request.setAttribute("error", "Correo o contraseña incorrectos.");
            request.getRequestDispatcher("inicioSesion.jsp").forward(request, response);
        }
    }
}
