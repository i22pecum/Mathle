package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

import data.dao.ProblemaDAO;
import data.dao.PartidaDAO;
import data.dto.Usuario;

@WebServlet("/RankingPartidaServlet")
public class RankingPartidaServlet extends HttpServlet {
    private PartidaDAO partidaDAO = new PartidaDAO();
    private ProblemaDAO problemaDAO = new ProblemaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        String modo = (String) session.getAttribute("modo");
        int dificultad = 0;
        dificultad = (int) session.getAttribute("dificultad");
        String fechaStr = (String) session.getAttribute("fecha");

        if (modo == null || dificultad == 0 || fechaStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetros requeridos: modo, dificultad y fecha.");
            return;
        }

        Date fecha;
        try {
            fecha = Date.valueOf(fechaStr); // formato esperado: yyyy-MM-dd
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Formato de fecha inválido. Usa yyyy-MM-dd.");
            return;
        }

        Integer idProblema = problemaDAO.obtenerIdProblemaPorCriterios(modo, dificultad, fecha);

        if (idProblema == null) {
            request.setAttribute("error", "No se encontró una partida con esos criterios.");
            request.getRequestDispatcher("./mvc/view/vistaRankingPartida.jsp").forward(request, response);
            return;
        }

        List<Usuario> ranking = partidaDAO.obtenerRankingPorProblema(idProblema);
        request.setAttribute("ranking", ranking);
        request.getRequestDispatcher("./mvc/view/vistaRankingPartida.jsp").forward(request, response);
    }
}
