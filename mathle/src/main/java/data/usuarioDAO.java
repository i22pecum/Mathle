import java.sql.*;

public class UsuarioDAO {
    private final String url = "jdbc:mariadb://localhost:3306/mathle";
    private final String user = "root";
    private final String password = "1234";

    public boolean existeEmail(String email) {
        String query = "SELECT email FROM usuarios WHERE email=?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return true; // prevenir registros si hay error
        }
    }

    public boolean insertarUsuario(String email, String nombre, String contraseña) {
    String query = "INSERT INTO usuarios (email, nombre, contraseña) VALUES (?, ?, ?)";
    try (Connection conn = DriverManager.getConnection(url, user, password);
         PreparedStatement stmt = conn.prepareStatement(query)) {

        // Cifrar la contraseña antes de insertarla
        String contraseñaCifrada = BCrypt.hashpw(contraseña, BCrypt.gensalt());

        stmt.setString(1, email);
        stmt.setString(2, nombre);
        stmt.setString(3, contraseñaCifrada);

        stmt.executeUpdate();
        return true;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
}
