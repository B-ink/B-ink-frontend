// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import ElementUI from 'element-ui'
import '../node_modules/element-ui/lib/theme-chalk/index.css'
import VueTouch from '../node_modules/vue-touch'
// import echarts from '../node_modules/echarts'
import Application from './js/app'
import VueAwesomeSwiper from 'vue-awesome-swiper'

Vue.use(ElementUI)
Vue.use(VueTouch, {name: 'v-touch'})
Vue.config.productionTip = false
Vue.use(VueAwesomeSwiper)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  created: function () {
    try {
      Application.init();
    } catch (err) {
      this.$message.error('请安装METAMASK插件，设置账户信息后刷新重试')
    }
  },
  components: {App},
  template: '<App/>'
})
