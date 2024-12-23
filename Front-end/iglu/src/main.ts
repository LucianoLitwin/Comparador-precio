/// <reference types="@angular/localize" />

import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';
import { Router } from '@angular/router';

document.addEventListener('DOMContentLoaded', () => {
  const splash = document.getElementById('splash-screen');

  if (splash) {
    splash.classList.add('hidden'); // Aplica la animación de ocultar
    setTimeout(() => {
      splash.remove(); // Elimina el splash screen después de la animación

      // Usa Angular Router para navegar sin recargar la página
      bootstrapApplication(AppComponent, appConfig)
        .then((appRef) => {
          const router = appRef.injector.get(Router);
          router.navigate(['/home']);
        })
        .catch((err) => console.error(err));
    }, 700);
  } else {
    bootstrapApplication(AppComponent, appConfig)
      .catch((err) => console.error(err));
  }
});
