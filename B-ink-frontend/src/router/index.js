import Vue from 'vue'
import Router from 'vue-router'
import Evaluation from '../view/Evaluation.vue'
import Login from '../view/Login.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      redirect: '/login'
    },
    {
      path: '/evaluation',
      name: 'Evaluation',
      component: Evaluation
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    }
  ]
})
