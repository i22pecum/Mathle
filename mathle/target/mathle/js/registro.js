document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");
    const nombreInput = document.getElementById("nombre");
    const correoInput = document.getElementById("correo");
    const contrasenaInput = document.getElementById("contrasena");
    const mensaje = document.getElementById("mensaje");
  
    const campos = [nombreInput, correoInput, contrasenaInput];
  
    form.addEventListener("submit", function (event) {
      let errores = [];
  
      // Limpiar estilos anteriores
      campos.forEach(campo => campo.style.border = "");
  
      if (!nombreInput.value.trim()) {
        errores.push("El nombre es obligatorio.");
        nombreInput.style.border = "2px solid red";
      }
  
      if (!correoInput.value.trim()) {
        errores.push("El correo es obligatorio.");
        correoInput.style.border = "2px solid red";
      }
  
      if (!contrasenaInput.value.trim()) {
        errores.push("La contraseña es obligatoria.");
        contrasenaInput.style.border = "2px solid red";
      }
  
      if (errores.length > 0) {
        event.preventDefault();
        mensaje.innerText = errores.join(" ");
        mensaje.style.color = "red";
      }
    });
  
    // Elimina el borde rojo cuando el usuario escribe
    campos.forEach(campo => {
      campo.addEventListener("input", () => {
        campo.style.border = "";
      });
    });
  });
  