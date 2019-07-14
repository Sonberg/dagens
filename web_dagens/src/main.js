import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import {
  createProvider
} from './vue-apollo'
import BootstrapVue from 'bootstrap-vue'
import Icon from './components/Icon'
import Vuelidate from 'vuelidate'
import * as VueGoogleMaps from 'vue2-google-maps'

import '@/styles/index.less'

import 'bootstrap-vue/dist/bootstrap-vue.css'
import 'bootstrap/dist/css/bootstrap.css'

Vue.use(Vuelidate)
Vue.use(BootstrapVue)
Vue.use(VueGoogleMaps, {
  load: {
    key: 'AIzaSyBVAr-YqSdLrEURzZoR4cTpmj50aOr8ZjU',
    libraries: 'places'
  }
});

Vue.component('v-icon', Icon)
Vue.config.productionTip = false

new Vue({
  router,
  store,
  apolloProvider: createProvider(),
  render: h => h(App)
}).$mount('#app')