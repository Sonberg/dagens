import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import auth0Client from './auth/index';

Vue.use(Router)

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [{
    path: '/',
    name: 'home',
    component: Home,
    meta: { protected: true }
  },
  {
    path: '/callback',
    name: 'callback',
    component: () => import( /* webpackChunkName: "callback" */ './views/Callback.vue')
  },
  {
    path: '/login',
    name: 'login',
    component: () => import( /* webpackChunkName: "callback" */ './views/Login.vue')
  },
  {
    path: '/companies/create',
    name: 'create-company',
    component: () => import( /* webpackChunkName: "company" */ './views/CreateCompany.vue'),
    meta: { protected: true }
  },
  {
    path: '/companies/:company_id',
    name: 'edit-company',
    component: () => import( /* webpackChunkName: "company" */ './views/Company.vue'),
    meta: { protected: true }
  },
  {
    path: '/companies/:company_id/edit',
    name: 'company',
    component: () => import( /* webpackChunkName: "company" */ './views/EditCompany.vue'),
    meta: { protected: true }
  }
  ]
});

router.beforeEach((to, from, next) => {
  if (!to.meta.protected) {
    return next();
  }

  if (auth0Client.isAuthenticated() && to.meta.protected) {
    return next();
  }

  localStorage.setItem('returnUrl', to.path);
  next(`/login`);
});

export default router;