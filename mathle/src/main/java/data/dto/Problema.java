package data.dto;

import java.sql.Date;

public class Problema {
    String operacion;
    int dificultad;
    Date fecha;
    String modoJuego;

    public Problema(){}

    public String getOperacion() {
        return operacion;
    }

    public void setOperacion(String operacion) {
        this.operacion = operacion;
    }

    public int getDificultad() {
        return dificultad;
    }

    public void setDificultad(int dificultad) {
        this.dificultad = dificultad;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getModoJuego() {
        return modoJuego;
    }

    public void setModoJuego(String modoJuego) {
        this.modoJuego = modoJuego;
    }

}
