import {Component, EventEmitter, OnInit, Output} from '@angular/core';
import {FormBuilder, FormControl, FormGroup, Validators} from '@angular/forms';
import {UserRegisterCmdDto} from '../../../shared/models/users/UserRegisterCmdDto';
import {UserLoginCmdDto} from '../../../shared/models/users/UserLoginCmdDto';

@Component({
  selector: 'app-login-form',
  templateUrl: './login-form.component.html',
  styles: [
  ]
})
export class LoginFormComponent implements OnInit {
  userLoginForm: FormGroup;
  usernameCtrl: FormControl;
  userPwdCtrl: FormControl;

  @Output() validUserChange = new EventEmitter<UserLoginCmdDto>();
  constructor(private formBuilder: FormBuilder) {
  }

  ngOnInit(): void {
    this.usernameCtrl = this.formBuilder.control('', Validators.required);
    this.userPwdCtrl = this.formBuilder.control('', Validators.required);

    this.userLoginForm = this.formBuilder.group({
        username: this.usernameCtrl,
        password: this.userPwdCtrl
      }
    );
  }

  isFormValid(): boolean {
    return this.userLoginForm.valid;
  }

  attemptLogin(): void {
    this.validUserChange.emit(new UserLoginCmdDto({
      username: this.usernameCtrl.value,
      password: this.userPwdCtrl.value
    }));
  }
}
