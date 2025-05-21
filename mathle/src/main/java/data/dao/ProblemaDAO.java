package data.dao;

import java.sql.*;

public class ProblemaDAO {
    
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

    public String obtenerOperacion(int dificultad, String modoJuego, Date fecha) {
        String query = "SELECT operacion FROM problema WHERE dificultad=? AND modoJuego=? AND fecha=?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, dificultad);
            stmt.setString(2, modoJuego);
            stmt.setDate(3, fecha);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getString("operacion");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertarProblema(int dificultad, String modoJuego, Date fecha, String operacion) {
        String query = "INSERT INTO problema (dificultad, modoJuego, fecha, operacion) VALUES (?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, dificultad);
            stmt.setString(2, modoJuego);
            stmt.setDate(3, fecha);
            stmt.setString(4, operacion);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Integer obtenerIdProblemaPorCriterios(String modoJuego, int dificultad, Date fecha) {
        String sql = "SELECT id FROM problema WHERE modoJuego = ? AND dificultad = ? AND fecha = ?";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, modoJuego);
            stmt.setInt(2, dificultad);
            stmt.setDate(3, fecha);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // No encontrado
    }

}
