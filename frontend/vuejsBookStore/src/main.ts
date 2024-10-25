import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { createBootstrap } from 'bootstrap-vue-next'
import Vue3Toastify, { type ToastContainerOptions } from 'vue3-toastify';


import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue-next/dist/bootstrap-vue-next.css'
import 'bootstrap'

import App from './App.vue'
import router from './router'

const app = createApp(App)

app.use(createPinia())
app.use(createBootstrap())
app.use(router)
app.use(Vue3Toastify, {
  autoClose: 3000,
} as ToastContainerOptions);

app.mount('#app')
