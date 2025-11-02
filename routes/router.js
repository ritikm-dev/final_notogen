const userController = require('../controller/usercontroller');
const Router = require('express').Router();
Router.post('/registration',userController.register);
Router.post('/login',userController.login);
Router.post('/demo',userController.demo)
module.exports = Router 