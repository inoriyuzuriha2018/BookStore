<template>
  <div class="d-flex justify-content-center parent-div">
    <cate-edit v-bind="state" @submit="onCategorySubmit" />
  </div>
</template>

<script setup lang="ts">
import cateEdit from '../../components/category/CategoryForm.vue'
import { createCategory, getCategory, patchCategory } from '@/services/Category'
import { useRoute, useRouter } from 'vue-router'
import { onMounted, reactive, ref, watch, computed } from 'vue'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'

const route = useRoute()

const state = reactive({
  category: {},
  errors: {},
})

const betweenStatus = x => {
  const sucess = [200, 299]
  return x >= sucess[0] && x <= sucess[1]
}

const onCategorySubmit = (category: {
  id: number
  title: string
  description: string
  image: File
}) => {
  state.category = category

  const formData = new FormData()

  formData.append('title', category.title)
  formData.append('description', category.description)
  if (category.image) formData.append('image', category.image)

  createCategory(formData)
    .then((response: any) => {
      if (betweenStatus(response.status)) {
        toast('Update data sucess', {
          theme: 'colored',
          type: 'success',
          dangerouslyHTMLString: true,
        })
      } else {
        console.log(response.error)
      }
    })
    .catch(e => {
      state.errors = e.response.data.errors
      toast('Something is wrong!', {
        theme: 'colored',
        type: 'error',
        dangerouslyHTMLString: true,
      })
    })
}
</script>

<style scoped>
.parent-div {
  height: 82vh;
}
</style>
