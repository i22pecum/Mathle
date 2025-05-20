package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.sql.*;

import java.io.IOException;

import data.common.OperacionGenerator;
import data.dao.ProblemaDAO;

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
        Date fecha = (Date) session.getAttribute("fecha");

        ProblemaDAO problemaDAO = new ProblemaDAO();

        String operacion = problemaDAO.obtenerOperacion(dificultad, modoJuego, fecha);

        if (operacion == null) {
            operacion = OperacionGenerator.generarOperacion(dificultad);
            problemaDAO.insertarProblema(dificultad, modoJuego, fecha, operacion);
        }

        session.setAttribute("operacion", operacion);

        //// Redirigir a la vista de partida
        request.getRequestDispatcher("mathle/mvc/view/registro.jsp").forward(request, response);
    }
}
