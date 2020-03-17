import { createReducer, createActions } from 'reduxsauce';
import Immutable from 'seamless-immutable';

import { AuthTypes } from '../auth';

/* Types & Action Creators */

const { Types, Creators } = createActions({
  actionType: ['dataPassed'],
});

export const UserTypes = Types;
export default Creators;

/* Initial State */

export const INITIAL_STATE = Immutable({
  profile: null,
});

/* Reducers */

export const success = (state, { user }) => ({
  ...state,
  profile: user,
  loading: false,
});

export const logout = state => INITIAL_STATE;

/* Reducers to types */

export const reducer = createReducer(INITIAL_STATE, {
  [AuthTypes.SIGN_IN_SUCCESS]: success,
  [AuthTypes.SIGN_OUT]: logout,
});
