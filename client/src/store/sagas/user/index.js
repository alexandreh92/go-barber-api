import { call, put } from 'redux-saga/effects';
import { toastr } from 'react-redux-toastr';

import api from '~/services/api';

import UserActions from '~/store/ducks/user';

export function* updateProfile({ data }) {
  try {
    const {
      name,
      password,
      passwordConfirmation,
      actualPassword,
      avatar,
    } = data;

    const fd = new FormData();

    if (avatar) fd.append('[profile]avatar', avatar);
    fd.append('[profile]name', name);

    if (actualPassword) {
      fd.append('[profile]current_password', actualPassword);
      fd.append('[profile]password', password);
      fd.append('[profile]password_confirmation', passwordConfirmation);
    }

    const response = yield call(api.put, 'profile', fd);

    toastr.success('Sucesso!', 'Perfil atualizado com sucesso.');

    yield put(UserActions.updateProfileSuccess(response.data));
  } catch (error) {
    toastr.error('Erro', error.response?.data?.errors[0]);
    yield put(UserActions.updateProfileFailure());
  }
}
