import { createGlobalStyle } from 'styled-components';

import 'react-redux-toastr/lib/css/react-redux-toastr.min.css';
import 'react-perfect-scrollbar/dist/css/styles.css';

export default createGlobalStyle`

* {
  margin: 0;
  padding: 0;
  outline: 0;
  box-sizing: border-box; 
}

*:focus {
  outline: 0;
}

html, body, #root {
  height: 100%;
  font: 14px 'Roboto', sans-serif;
}

body {
  -webkit-font-smoothing: antialiased;
}

form, input, button {
  font: 14px 'Roboto', sans-serif
}

a {
  text-decoration: none;
}

ul {
  list-style: none;
}

button {
  cursor: pointer;
}
`;
