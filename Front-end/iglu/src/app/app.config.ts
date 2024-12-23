import { provideRouter } from '@angular/router';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { routes } from './app.routes';
import { appHttpInterceptor } from './core/interceptors/app-http.interceptor';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppErrorHandler } from './core/handlers/app-error-handler';
import { AppMessageService } from './core/services/app-message.service';
import { LoaderService } from './core/services/loader.service';
import { ApplicationConfig, ErrorHandler, importProvidersFrom } from '@angular/core';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';

export const appConfig: ApplicationConfig = {
  providers: [
    provideHttpClient(withInterceptors([appHttpInterceptor])),
    provideRouter(routes),
    importProvidersFrom(BrowserAnimationsModule),
    AppMessageService,
    LoaderService,
    { provide: ErrorHandler, useClass: AppErrorHandler }, provideAnimationsAsync(),
  ]
};
