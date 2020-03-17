/* eslint-disable no-unused-vars */
import { persistStore } from 'redux-persist';
import createSagaMiddleware from 'redux-saga';
// import { routerMiddleware } from 'connected-react-router';
// import jwtDecode from 'jwt-decode';

import createStore from './createStore';
import persistReducers from './persistReducers';

import history from '../services/history';
import rootReducer from './ducks';
import rootSaga from './sagas';

const sagaMonitor =
  process.env.NODE_ENV === 'development'
    ? console.tron.createSagaMonitor()
    : null;

const sagaMiddleware = createSagaMiddleware({ sagaMonitor });

const middlewares = [sagaMiddleware];

const store = createStore(persistReducers(rootReducer), middlewares);
const persistor = persistStore(store);

sagaMiddleware.run(rootSaga);

export { persistor, store };
