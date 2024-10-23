import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import AboutView from '../views/AboutView.vue'
import Layout from '../layouts/app.vue'

const routes = [
  {
    path: '/',
    name: 'LayoutA',
    component: Layout,
    children: [
      {
        path: '/',
        name: 'home',
        component: HomeView,
      },
    ],
  },
  {
    path: '/about',
    name: 'about1',
    // route level code-splitting
    // this generates a separate chunk (About.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: AboutView,
  },
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
})

export default router
