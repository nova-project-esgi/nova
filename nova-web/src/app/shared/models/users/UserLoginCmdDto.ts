import {ObjectUtils} from '../../utils/object.utils';

export class UserLogin {
  username = '';
  password = '';

  constructor(user?: Partial<UserLogin>) {
    ObjectUtils.copyExistingProperties(user, this);
  }
}
