import React from 'react';
import { Provider } from 'react-redux';
import { PersistGate } from 'redux-persist/integration/react';
import { Router } from 'react-router-dom';
import ReduxToastr from 'react-redux-toastr';

import '~/config/ReactotronConfig';

import history from './services/history';
import { store, persistor } from '~/store';

import '~/styles/fonts.css';
import GlobalStyle from '~/styles/global';

import Routes from './routes';

function App() {
  return (
    <Provider store={store}>
      <PersistGate persistor={persistor}>
        <Router history={history}>
          <GlobalStyle />
          <ReduxToastr
            timeOut={4000}
            newestOnTop={false}
            preventDuplicates
            position="bottom-right"
            getState={state => state.toastr}
            transitionIn="fadeIn"
            transitionOut="fadeOut"
            progressBar
            closeOnToastrClick
          />
          <Routes />
        </Router>
      </PersistGate>
    </Provider>
  );
}

export default App;
