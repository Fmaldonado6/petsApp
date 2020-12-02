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
import { AccountPage } from './pages/account/account.component';
import { EmptyComponent } from './components/shared/empty/empty.component';
import { AddPetModal } from './components/modals/pets/add-pet/add-pet.component';
import { SwingModule } from 'angular2-swing';
import { InfoPetComponent } from './components/modals/pets/info-pet/info-pet.component';
import { ConfirmComponent } from './components/modals/confirm/confirm.component';
import { ErrorComponent } from './components/shared/error/error.component';
import {IvyGalleryModule} from 'angular-gallery';
import { EditPetComponent } from './components/modals/pets/edit-pet/edit-pet.component';
import { EditPicturesComponent } from './components/modals/edit-pictures/edit-pictures.component';
import { EditUserComponent } from './components/modals/users/edit-user/edit-user.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    AddUserModal,
    InfoMenuComponent,
    LoggedInComponent,
    NavbarComponent,
    MainPage,
    AccountPage,
    EmptyComponent,
    AddPetModal,
    InfoPetComponent,
    ConfirmComponent,
    ErrorComponent,
    EditPetComponent,
    EditPicturesComponent,
    EditUserComponent,
  ],
  imports: [
    BrowserModule,
    ReactiveFormsModule,
    AppRoutingModule,
    MaterialModule,
    HttpClientModule,
    SwingModule,
    IvyGalleryModule,
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
