<h1 align="center">
    <p><span style="color:#7159c1">Go Barber</span> API</p>
</h1>

<p align="center">
  <img alt="GitHub top language" src="https://img.shields.io/github/languages/top/alexandreh92/go-barber-api">

  <a href='https://coveralls.io/github/alexandreh92/go-barber-api?branch=master'>
    <img src='https://coveralls.io/repos/github/alexandreh92/go-barber-api/badge.svg?branch=master' alt='Coverage Status' />
  </a>

  <a href="https://codeclimate.com/github/alexandreh92/go-barber-api">
    <img alt="Code Climate technical debt" src="https://img.shields.io/codeclimate/tech-debt/alexandreh92/go-barber-api">
  </a>

  <img alt="Repository size" src="https://img.shields.io/github/repo-size/alexandreh92/go-barber-api">

  <img alt="Github license" src="https://img.shields.io/github/license/alexandreh92/go-barber-api">
</p>

<h3 align="center">
  Hi, this is the Go Barber API made in Ruby on Rails during <strong><a href='https://www.rocketseat.com.br'>Rocketseat's</a> GoStack 10</strong> course.
</h3>

<p align="center">This project is an API which provides information for <a href='https://github.com/alexandreh92/go-barber'>Go Barber Web</a> project.
</p>

<br/>

<p align="center">
  <a href="https://go-barber-rails.herokuapp.com/api-docs/index.html" target="_blank">
    <img alt="Demo on Heroku" src="https://res.cloudinary.com/practicaldev/image/fetch/s--lPYRHjTu--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://dev-to-uploads.s3.amazonaws.com/i/yhsx4dce2f7l0iiufibi.jpg" width="150">
  </a>
</p>

---

## Feature Highlights

1. JWT Authentication - [[devise](https://github.com/heartcombo/devise) with [devise-jwt](https://github.com/waiting-for-dev/devise-jwt)]
2. Swagger Documentation - [integrated in RSpec with [rswag](https://github.com/rswag/rswag)]
3. Automated File Uploads - [[carrierwave](https://github.com/carrierwaveuploader/carrierwave)]

---

## Prerequisites

Have the following features with their respective versions installed on the machine:

- Node `12.x+` - You can use [NVM](https://github.com/nvm-sh/nvm)
- Ruby `2.7.5` - You can use [RVM](http://rvm.io)
- PostgreSQL `12+`
  - OSX - `$ brew install postgresql` or install [Postgress.app](http://postgresapp.com/)
  - Linux - `$ sudo apt-get install postgresql`
  - Windows - [PostgreSQL for Windows](http://www.postgresql.org/download/windows/)
- Bundler `2.x+`

---

## Setup the project

After you get all the [prerequisites](#prerequisites), simply execute the following commands in sequence:

```bash
1. $ cd go-barber-api # Go into the project folder
2. $ bundle install # Install ruby dependencies
3. $ rake db:create # Creates db
4. $ rake db:migrate # Migrates db
5. $ rspec spec # Run the specs to see if everything is working fine
```

---

This project was made with ♥&nbsp;by alexandreh92 [Get in touch!](https://www.linkedin.com/in/alexandreh92/)
