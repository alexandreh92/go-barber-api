import { call, put } from 'redux-saga/effects';
import { actions as toastrActions } from 'react-redux-toastr';

import history from '~/services/history';

import api from '~/services/api';

import AuthActions from '~/store/ducks/auth';

export function* signIn({ email, password }) {
  try {
    const response = yield call(api.post, 'sessions', {
      user: { email, password },
    });

    const { user, token } = response.data;

    if (!user.provider) {
      console.tron.error('Usuario nao eh prestador');
      return;
    }

    yield put(AuthActions.signInSuccess(token, user));

    history.push('/');
  } catch (error) {
    yield put(
      toastrActions.add({
        type: 'error',
        title: 'Falha no login',
        message: 'Verifique seu e-mail/senha!',
      })
    );
  }
}

export function signOut() {
  history.push('/');
}
