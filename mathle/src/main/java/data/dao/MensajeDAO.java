package data.dao;

import java.sql.*;
import java.util.*;
import data.dto.Mensaje;

public class MensajeDAO {
    private final String url = "jdbc:mariadb://localhost:3306/mathle";
    private final String user = "root";
    private final String password = "1234";

    // Publicar mensaje
    public boolean publicarMensaje(String autor, String mensaje, Timestamp fecha) {
        String query = "INSERT INTO mensaje (autor, mensaje, fecha) VALUES (?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, autor);
            stmt.setString(2, mensaje);
            stmt.setTimestamp(3, fecha);
            stmt.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Obtener mensajes como lista de mapas
    public List<Mensaje> obtenerMensajes() {
        List<Mensaje> mensajes = new ArrayList<>();
        String query = "SELECT autor, mensaje, fecha FROM mensaje ORDER BY fecha DESC";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Mensaje mensaje = new Mensaje( rs.getString("autor"), rs.getTimestamp("fecha"), rs.getString("mensaje"));
                mensajes.add(mensaje);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return mensajes;
    }

}
