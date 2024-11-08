import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import AboutView from '../views/AboutView.vue'
import Layout from '../layouts/app.vue'
import CategoryLayout from '../layouts/CategoryLayout.vue' // Layout chính
import CategoryList from '../views/categories/list.vue'
import CategoryEdit from '../views/categories/edit.vue'
import CategoryNew from '@/views/categories/new.vue'
import PostLayout from '../layouts/Post.vue'
import PostList from '../views/posts/list.vue'
import PostEdit from '../views/posts/edit.vue'

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
      {
        path: 'new',
        name: 'CategoryNew',
        component: CategoryNew,
        props: true,
      },
    ],
  },
  {
    path: '/posts',
    component: PostLayout,
    children: [
      {
        path: '',
        name: 'PostList',
        component: PostList,
      },
      {
        path: 'edit/:id',
        name: 'PostEdit',
        component: PostEdit,
      },
    ],
  },
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
})

export default router
