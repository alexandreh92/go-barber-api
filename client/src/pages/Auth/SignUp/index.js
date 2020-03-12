import React from 'react';
import { Link } from 'react-router-dom';
import { Form, Input } from '@rocketseat/unform';
import * as Yup from 'yup';

import logo from '~/assets/logo.svg';

const schema = Yup.object().shape({
  name: Yup.string().required('Nome é obrigatório'),
  email: Yup.string()
    .email('Insira um e-mail válido')
    .required('O e-mail é obrigatório'),
  password: Yup.string()
    .min(6, 'No mínimo 6 caracteres')
    .required('A senha é obrigatória'),
  password_confirmation: Yup.string()
    .min(6, 'No mínimo 6 caracteres')
    .required('A confirmação de senha é obrigatória'),
});

export default function SignUp() {
  function handleSubmit({ name, email, password, password_confirmation }) {
    console.log(name, email, password, password_confirmation);
  }

  return (
    <>
      <img src={logo} alt="GoBarber" />

      <Form schema={schema} onSubmit={handleSubmit}>
        <Input name="name" placeholder="Nome Completo" />
        <Input name="email" type="email" placeholder="Seu e-mail" />
        <Input
          name="password"
          type="password"
          placeholder="Sua senha secreta"
        />
        <Input
          name="password_confirmation"
          type="password"
          placeholder="Repita sua senha"
        />

        <button type="submit">Criar Conta</button>
        <Link to="/">Já tenho login</Link>
      </Form>
    </>
  );
}
