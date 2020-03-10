import React from 'react';
import logo from './logo.svg';
import './App.css';
import api from '~/services/api';

function App() {
  function handleClick() {
    api
      .post('sessions', {
        user: { email: 'admin@admin', password: '123123' },
      })
      .then(res => console.log(res.data));
  }

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <button onClick={handleClick}>Crick</button>
      </header>
    </div>
  );
}

export default App;
