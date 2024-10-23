import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import AboutView from '../views/AboutView.vue'
import Layout from '../layouts/app.vue'
import CategoryLayout from '../layouts/CategoryLayout.vue' // Layout chính
import CategoryList from '../components/category/CategoryList.vue'
import CategoryEdit from '@/components/category/CategoryEdit.vue'

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
    component: AboutView,
  },
  {
    path: '/categories',
    component: CategoryLayout, // Component cha
    children: [
      {
        path: '',
        name: 'CategoryList',
        component: CategoryList,
      },
      {
        path: 'edit/:id',
        name: 'CategoryEdit',
        component: CategoryEdit,
        props: true,
      },
    ],
  },
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
})

export default router
