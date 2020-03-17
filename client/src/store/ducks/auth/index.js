import { createReducer, createActions } from 'reduxsauce';
import Immutable from 'seamless-immutable';

/* Types & Action Creators */

const { Types, Creators } = createActions({
  signInRequest: ['email', 'password'],
  signInSuccess: ['token', 'user'],
  signOut: null,
  setLoading: null,
});

export const AuthTypes = Types;
export default Creators;

/* Initial State */

export const INITIAL_STATE = Immutable({
  signedIn: false,
  token: null,
  loading: false,
});

/* Reducers */

export const success = (state, { token }) => ({
  ...state,
  signedIn: true,
  token,
  loading: false,
});

export const logout = state => ({ ...state, signedIn: false, token: null });

export const loading = state => ({ ...state, loading: !state.loading });

/* Reducers to types */

export const reducer = createReducer(INITIAL_STATE, {
  [Types.SIGN_IN_SUCCESS]: success,
  [Types.SIGN_OUT]: logout,
  [Types.SET_LOADING]: loading,
});