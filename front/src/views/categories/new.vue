<template>
  <div class="d-flex justify-content-center parent-div">
    <category-form v-bind="state" @submit="onCategorySubmit" />
  </div>
</template>

<script setup lang="ts">
import CategoryForm from '../../components/category/CategoryForm.vue'
import { createCategory } from '@/services/Category'
import { reactive } from 'vue'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'
import type { Category } from '@/interfaces/Category'
import { useRouter } from 'vue-router'

const router = useRouter()

const state = reactive({
  category: {} as Category,
  errors: {},
})

const onCategorySubmit = (category: Category) => {
  state.category = category

  const formData = new FormData()
  formData.append('title', category.title)
  formData.append('description', category.description)
  if (category.image) formData.append('image', category.image)

  createCategory(formData)
    .then(() => {
      toast('Update data sucess', {
        theme: 'colored',
        type: 'success',
        dangerouslyHTMLString: true,
      })
      router.push({ name: 'CategoryList' })
    })
    .catch(e => {
      state.errors = e.response.data.errors
    })
}
</script>

<style scoped>
.parent-div {
  height: 90vh;
}
</style>
