import { createWebHistory, createRouter } from 'vue-router'

import HomeView from '../components/HomeView.vue'
import ApplicationView from '../components/ApplicationView.vue'
import ApplicationEditView from '../components/ApplicationEditView.vue'

const routes = [
  { path: '/', component: HomeView },
  { path: '/applications/:id', name: 'Application', component: ApplicationView, props: true },
  { path: '/applications/:id/edit', name: 'ApplicationEdit', component: ApplicationEditView, props: true },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
