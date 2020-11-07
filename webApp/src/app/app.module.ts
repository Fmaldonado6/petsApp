import { MaterialModule } from './material/material.module';
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { FlexLayoutModule } from '@angular/flex-layout';
import { LoginComponent } from './components/layout/login/login.component';
import { AddUserModal } from './components/modals/users/add-user/add-user.component';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { ReactiveFormsModule } from '@angular/forms';
import { InfoMenuComponent } from './components/modals/info-menu/info-menu.component';
import { TokenInterceptorService } from './services/api/token-interceptor.service';
import { LoggedInComponent } from './components/layout/logged-in/logged-in.component';
import { NavbarComponent } from './components/layout/navbar/navbar.component';
import { MainPage } from './pages/main/main.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    AddUserModal,
    InfoMenuComponent,
    LoggedInComponent,
    NavbarComponent,
    MainPage
  ],
  imports: [
    BrowserModule,
    ReactiveFormsModule,
    AppRoutingModule,
    MaterialModule,
    HttpClientModule,

    FlexLayoutModule
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: TokenInterceptorService,
      multi: true
    }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
