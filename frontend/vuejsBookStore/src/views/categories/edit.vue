<template>
  <div class="d-flex justify-content-center parent-div">
    <category-form v-bind="state" @submit="onCategorySubmit" />
  </div>
</template>

<script setup lang="ts">
import CategoryForm from '../../components/category/CategoryForm.vue'
import { getCategory, patchCategory } from '@/services/Category'
import { useRoute, useRouter } from 'vue-router'
import { onMounted, reactive } from 'vue'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'
import type { Category } from '@/interfaces/Category'
import { c } from 'node_modules/vite/dist/node/types.d-aGj9QkWt'

const route = useRoute()
const router = useRouter()

const state = reactive({
  category: {} as Category,
  errors: {},
})

onMounted(() => {
  getCategory(+route.params.id)
    .then((response: any) => {
      if (Object.keys(response.data).length > 0) {
        state.category = response.data
      }
    })
    .catch(e => {
      console.log(e)
    })
})

const onCategorySubmit = (category: Category) => {
  state.category = category
  const formData = new FormData()

  formData.append('title', category.title)
  formData.append('description', category.description)
  if (category.image != null) formData.append('image', category.image)

  patchCategory(category.id, formData)
    .then((response: any) => {
      router.push({ name: 'CategoryList' })
    })
    .catch(e => {
      console.log(e)
    })
}
</script>

<style scoped>
.parent-div {
  height: 90vh;
}
</style>
