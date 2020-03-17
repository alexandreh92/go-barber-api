import React from 'react';
import { useDispatch } from 'react-redux';

import AuthActions from '~/store/ducks/auth';

// import { Container } from './styles';

export default function Dashboard() {
  const dispatch = useDispatch();

  return (
    <button type="button" onClick={() => dispatch(AuthActions.signOut())}>
      dasdasdsa
    </button>
  );
}
