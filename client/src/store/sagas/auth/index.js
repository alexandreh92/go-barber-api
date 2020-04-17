import { call, put } from 'redux-saga/effects';
import { toastr } from 'react-redux-toastr';

import history from '~/services/history';

import api from '~/services/api';

import AuthActions from '~/store/ducks/auth';

export function* signIn({ email, password }) {
  yield put(AuthActions.setLoading());
  try {
    const response = yield call(api.post, 'sessions', {
      user: { email, password },
    });

    const { user, token } = response.data;

    if (!user.provider) {
      toastr.error(
        'Falha no login',
        'Somente prestadores podem acessar o painel de controle.'
      );
      yield put(AuthActions.setLoading());
      return;
    }

    yield put(AuthActions.signInSuccess(token, user));

    history.push('/');
  } catch (error) {
    toastr.error('Falha no login', 'Verifique seu e-mail/senha!');
    yield put(AuthActions.setLoading());
  }
}

export function signOut() {
  history.push('/');
}
