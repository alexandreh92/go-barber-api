import { createReducer, createActions } from 'reduxsauce';
import Immutable from 'seamless-immutable';

import { AuthTypes } from '../auth';

/* Types & Action Creators */

const { Types, Creators } = createActions({
  updateProfileRequest: ['data'],
  updateProfileSuccess: ['profile'],
  updateProfileFailure: null,
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

export const logout = () => INITIAL_STATE;

export const updateSuccess = (state, { profile }) => ({
  ...state,
  profile,
});

/* Reducers to types */

export const reducer = createReducer(INITIAL_STATE, {
  [AuthTypes.SIGN_IN_SUCCESS]: success,
  [AuthTypes.SIGN_OUT]: logout,
  [UserTypes.UPDATE_PROFILE_SUCCESS]: updateSuccess,
});
