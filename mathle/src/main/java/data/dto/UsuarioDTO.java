package data.dto;

public class UsuarioDTO{
    private String nombre;
    private int puntuacion;

    public UsuarioDTO(String nombre, int puntuacion) {
        this.nombre = nombre;
        this.puntuacion = puntuacion;
    }

    public String getNombre() {
        return nombre;
    }

    public int getPuntuacion() {
        return puntuacion;
    }
}