package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.sql.*;
import java.io.IOException;

import data.dao.ProblemaDAO;
import data.dao.UsuarioDAO;
import data.dao.PartidaDAO;

import data.dto.Usuario;

@WebServlet("/partida")
public class PartidaServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        if (usuario == null) {
            response.sendRedirect("/mathle/RankingPartidaServlet");
            return;
        }

        String tiempoStr = request.getParameter("tiempo");
        String intentosStr = request.getParameter("intentos");
        int tiempo = Integer.parseInt(tiempoStr);
        int intentos = Integer.parseInt(intentosStr);
        int idProblema = 0;

        
        int dificultad = (int) session.getAttribute("dificultad");

        float puntuacion = calcularPuntuacion(intentos, tiempo, dificultad);

        //Meter puntuacion en la bbdd

        String modo = (String) session.getAttribute("modoJuego");
        String fechaStr = (String) session.getAttribute("fecha");
        Date fecha = Date.valueOf(fechaStr);

        ProblemaDAO problemaDAO = new ProblemaDAO();
        idProblema = problemaDAO.obtenerIdProblemaPorCriterios(modo, dificultad, fecha);

        PartidaDAO partidaDAO = new PartidaDAO();
        partidaDAO.insertarPartida(usuario.getNombre(), idProblema, puntuacion, tiempo, intentos);

        usuario.aumentarPuntuacion(puntuacion);

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        usuarioDAO.actualizarPuntuacion(usuario.getNombre(), usuario.getPuntuacion());

        response.sendRedirect("/mathle/RankingPartidaServlet");
    }

    private float calcularPuntuacion(int intentos, int tiempo, int dificultad) {
        float puntuacion = 0;

        puntuacion = 7 - intentos;

        if(tiempo > 0 && tiempo <= 15){
            puntuacion += 4;
        }
        else if(tiempo > 15 && tiempo <= 30){
            puntuacion += 3;
        }
        else if(tiempo > 30 && tiempo <= 45){
            puntuacion += 2;
        }
        else if(tiempo > 45 && tiempo <= 60){
            puntuacion += 1;
        }

        switch (dificultad) {
            case 6:
                puntuacion *= 1;
                break;
            case 8:
                puntuacion *= 1.2;
                break;
            case 10:
                puntuacion *= 1.4;
                break;
            case 12:
                puntuacion *= 1.6;
                break;
        }

        return puntuacion; 
    }
}
