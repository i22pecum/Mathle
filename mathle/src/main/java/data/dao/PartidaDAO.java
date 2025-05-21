package data.dao;

import org.checkerframework.checker.units.qual.s;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import data.dto.Usuario;


public class PartidaDAO {
    private final String url = "jdbc:mariadb://localhost:3306/mathle";
    private final String user = "root";
    private final String password = "1234";


    //Fuerza a cargar el driver de MariaDB
    static {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public List<Usuario> obtenerRankingPorProblema(int idProblema) {
        List<Usuario> ranking = new ArrayList<>();
        String sql = "SELECT nombreUsuario, puntuacion FROM partida WHERE idProblema = ? ORDER BY puntuacion DESC";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idProblema);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setNombre(rs.getString("nombreUsuario"));
                usuario.setPuntuacion(rs.getFloat("puntuacion")); // puntuación de esa partida
                ranking.add(usuario);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return ranking;
    }

    public Boolean insertarPartida(String nombreUsuario, int idProblema, float puntuacion, int duracion, int intentos) {
        String query = "INSERT INTO partida (nombreUsuario, idProblema, puntuacion, duracion, intentos) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, nombreUsuario);
            stmt.setInt(2, idProblema);
            stmt.setFloat(3, puntuacion);
            stmt.setInt(4, duracion);
            stmt.setInt(5, intentos);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean comprobarPartida(String nombreUsuario, int idProblema) {
        String query = "SELECT * FROM partida WHERE nombreUsuario = ? AND idProblema = ?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, nombreUsuario);
            stmt.setInt(2, idProblema);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}

