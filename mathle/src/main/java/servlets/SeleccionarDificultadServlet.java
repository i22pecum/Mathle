package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.sql.*;

import java.io.IOException;

import data.common.OperacionGenerator;
import data.dao.ProblemaDAO;
import data.dao.PartidaDAO;
import data.dto.Usuario;

@WebServlet("/seleccionarDificultad")
public class SeleccionarDificultadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String dificultadStr = request.getParameter("dificultad");

        if (dificultadStr == null || dificultadStr.trim().isEmpty()) {
            request.setAttribute("mensaje", "Debes seleccionar una dificultad.");
            request.getRequestDispatcher("/mathle/mvc/view/seleccionarDificultad.jsp").forward(request, response);
            return;
        }

        // Guardar dificultad en sesión
        HttpSession session = request.getSession();
        int dificultad = Integer.parseInt(dificultadStr);
        session.setAttribute("dificultad", dificultad);
        String modoJuego = (String) session.getAttribute("modoJuego");

        String fechaStr = (String) session.getAttribute("fecha");

        Date fecha = Date.valueOf(fechaStr);

        // Comprobar si el usuario ha jugado la partida antes

        ProblemaDAO problemaDAO = new ProblemaDAO();

        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if(usuario != null) {
            int idProblema = problemaDAO.obtenerIdProblemaPorCriterios(modoJuego, dificultad, fecha);
            PartidaDAO partidaDAO = new PartidaDAO();
            if(partidaDAO.comprobarPartida(usuario.getNombre(), idProblema)){
                response.sendRedirect("/mathle/RankingPartidaServlet");
                return;
            }

        }

        String operacion = problemaDAO.obtenerOperacion(dificultad, modoJuego, fecha);

        if (operacion == null) {
            operacion = OperacionGenerator.generarOperacion(dificultad);
            problemaDAO.insertarProblema(dificultad, modoJuego, fecha, operacion);
        }

        session.setAttribute("operacion", operacion);

        //// Redirigir a la vista de partida
        request.getRequestDispatcher("mvc/view/vistaPartida.jsp").forward(request, response);
    }
}
