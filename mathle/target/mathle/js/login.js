document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");
    const correoInput = document.getElementById("correo");
    const contrasenaInput = document.getElementById("contrasena");
    const mensaje = document.getElementById("mensaje");
  
    form.addEventListener("submit", function (event) {
      let errores = [];
  
      if (!correoInput.value.trim()) {
        errores.push("El correo es obligatorio.");
      }
  
      if (!contrasenaInput.value.trim()) {
        errores.push("La contraseña es obligatoria.");
      }
  
      if (errores.length > 0) {
        event.preventDefault(); // Evita que se envíe el formulario
        mensaje.innerText = errores.join(" ");
        mensaje.style.color = "red";
      }
    });
  });
  