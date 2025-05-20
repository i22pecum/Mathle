package data.dao;

import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import data.dto.Usuario;

public class UsuarioDAO {
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

    public boolean existeCorreo(String correo) {
        String query = "SELECT correo FROM usuario WHERE correo=?";
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

    public boolean existeNombre(String nombre) {
        String query = "SELECT nombre FROM usuario WHERE nombre=?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, nombre);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return true; // prevenir registros si hay error
        }
    }

    public boolean insertarUsuario(String correo, String nombre, String contrasena) {
        String query = "INSERT INTO usuario (correo, nombre, contrasena) VALUES (?, ?, ?)";
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
        String query = "SELECT contrasena FROM usuario WHERE correo=?";
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
    public Usuario obtenerDatosUsuario(String correo) {
        String query = "SELECT nombre, puntuacion, tema FROM usuario WHERE correo=?";
        Usuario usuario = new Usuario();
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1,correo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                usuario.setCorreo(correo);
                usuario.setNombre(rs.getString("nombre"));
                usuario.setPuntuacion(rs.getInt("puntuacion"));
                usuario.setTema(rs.getString("tema"));
                return usuario;
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
        
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                String nombre = rs.getString("nombre");
                int puntuacion = rs.getInt("puntuacion");
                ranking.add(new Usuario(nombre, puntuacion));
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Considera usar logging en producción
        }

        return ranking;
    }
        
}

