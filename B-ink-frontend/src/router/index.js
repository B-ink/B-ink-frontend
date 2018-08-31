import Vue from 'vue'
import Router from 'vue-router'
import Evaluation from '../view/Evaluation.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Evaluation',
      component: Evaluation
    }
  ]
})
