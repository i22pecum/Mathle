package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import data.dao.UsuarioDAO;
import data.dto.Usuario;

@WebServlet("/ranking")
public class RankingServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;

    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Usuario> ranking = usuarioDAO.obtenerRanking();
        request.setAttribute("ranking", ranking);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ranking.jsp");
        dispatcher.forward(request, response);
    }

}

