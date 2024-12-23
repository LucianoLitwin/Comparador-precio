// home.component.ts
import { Component, OnInit, signal } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { SidebarComponent } from '../sidebar/sidebar.component';
import { MatSidenavModule } from '@angular/material/sidenav';
import { Router } from '@angular/router';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [MatSidenavModule, MatCardModule, MatIconModule, MatButtonModule, SidebarComponent],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent implements OnInit {
  welcomeMessage: string = '';
  secondMessage: string = '';
  hasVisited = signal(localStorage.getItem('hasVisited') === 'true');

  constructor(private router: Router) { }

  ngOnInit(): void {
    this.setWelcomeMessages();
  }

  private setWelcomeMessages(): void {
    if (this.hasVisited()) {
      this.welcomeMessage = $localize`Bienvenido de nuevo al comparador de precios del`;
      this.secondMessage = $localize`¡Nos alegra tenerte aquí otra vez!`;
    } else {
      this.welcomeMessage = $localize`Bienvenido al comparador de precios del`;
      this.secondMessage = $localize`Explora y encuentra las mejores opciones de precios.`;

      // Guarda el estado de visita en localStorage
      localStorage.setItem('hasVisited', 'true');
    }
  }

  navigateToMap(): void {
    this.router.navigate(['/map']);
  }
}