import {NgModule} from '@angular/core';
import {RouteReuseStrategy, RouterModule, Routes} from '@angular/router';
import {ShouldReuseStrategy} from './core/commons/route-strategies/should-reuse-strategy';
import {NoMatchRedirectGuardService} from './core/guards/no-match-redirect-guard.service';
import {HomeRootComponent} from './public/home/home-root/home-root.component';


const routes: Routes = [
  {path: '', redirectTo: '/home', pathMatch: 'full'},
  {path: '**', component: HomeRootComponent, canActivate: [NoMatchRedirectGuardService]}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
  providers: [{provide: RouteReuseStrategy, useClass: ShouldReuseStrategy}]
})
export class AppRoutingModule {
}
