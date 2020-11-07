import { AccountPage } from './pages/account/account.component';
import { MainPage } from './pages/main/main.component';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

const routes: Routes = [
  {
    path: "",
    component: MainPage
  },
  {
    path: "account/:id",
    component: AccountPage
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
