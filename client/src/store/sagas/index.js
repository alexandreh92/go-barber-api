import { all, takeLatest } from 'redux-saga/effects';

import { signIn, signOut } from './auth';
import { AuthTypes } from '~/store/ducks/auth';

import { updateProfile } from './user';
import { UserTypes } from '~/store/ducks/user';

export default function* rootSaga() {
  return yield all([
    takeLatest(AuthTypes.SIGN_IN_REQUEST, signIn),
    takeLatest(AuthTypes.SIGN_OUT, signOut),
    takeLatest(UserTypes.UPDATE_PROFILE_REQUEST, updateProfile),
  ]);
}
