import axios from 'axios';

import { store } from '~/store';

const api = axios.create({
  baseURL: '/api',
});

// INTERCEPTOR FOR AUTH
api.interceptors.request.use(
  function(config) {
    const { token } = store.getState().auth;

    if (token !== null) {
      config.headers.Authorization = `Bearer ${token}`;
    }

    return config;
  },
  function(err) {
    return Promise.reject(err);
  }
);

export default api;
