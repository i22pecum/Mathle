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
                String hashContrasena = rs.getString("contrasena");
                return BCrypt.checkpw(contrasena, hashContrasena);
            } else {
                return false; // Usuario no encontrado
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false; // En caso de error, no autenticar
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

    public List<Usuario> obtenerRankingGlobal() {
        List<Usuario> ranking = new ArrayList<>();
        String sql = "SELECT nombre, puntuacion FROM usuario ORDER BY puntuacion DESC";
        
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                String nombre = rs.getString("nombre");
                float puntuacion = rs.getFloat("puntuacion");
                ranking.add(new Usuario(nombre, puntuacion));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ranking;
    }

    public boolean actualizarPuntuacion(String correo, float puntuacion) {
        String query = "UPDATE usuario SET puntuacion = ? WHERE correo = ?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setFloat(1, puntuacion);
            stmt.setString(2, correo);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarTema(String correo, String tema) {
        String query = "UPDATE usuario SET tema = ? WHERE correo = ?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
            PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, tema);
            stmt.setString(2, correo);
            int filasActualizadas = stmt.executeUpdate();
            return filasActualizadas == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
        
}

