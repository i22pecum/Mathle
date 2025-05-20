import java.sql.*;


public class UsuarioDAO {
    private final String url = "jdbc:mariadb://localhost:3306/mathle";
    private final String user = "root";
    private final String password = "1234";

    public boolean existeCorreo(String correo) {
        String query = "SELECT correo FROM usuarios WHERE correo=?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, correo);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return true; // prevenir registros si hay error
        }
    }

    public boolean insertarUsuario(String correo, String nombre, String contrasena) {
        String query = "INSERT INTO usuarios (correo, nombre, contrasena) VALUES (?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(url, user, password);
            PreparedStatement stmt = conn.prepareStatement(query)) {

            // Cifrar la contraseña antes de insertarla
            String contrasenaCifrada = BCrypt.hashpw(contrasena, BCrypt.gensalt());

            stmt.setString(1, correo);
            stmt.setString(2, nombre);
            stmt.setString(3, contrasenaCifrada);

            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    //Verifica credenciales
    public boolean verificarCredenciales(String correo, String contrasena) {
        String query = "SELECT contrasena FROM usuarios WHERE correo=?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, correo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String contrasenaHash = rs.getString("contrasena");
                return BCrypt.checkpw(contrasena, contrasenaHash);
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    //Obtener nombre de usuario por correo
    public String obtenerNombre(String correo) {
        String query = "SELECT nombre FROM usuarios WHERE correo=?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1,correo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getString("nombre");
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Usuario> obtenerRanking() {
        List<Usuario> ranking = new ArrayList<>();
        String sql = "SELECT nombre, puntuacion FROM usuarios ORDER BY puntuacion DESC";
    
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPassword);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                String nombre = rs.getString("nombre");
                int puntuacion = rs.getInt("puntuacion");
                ranking.add(new Usuario(nombre, puntuacion));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // En producción, usa logging
        }
        return ranking;
    }

}

