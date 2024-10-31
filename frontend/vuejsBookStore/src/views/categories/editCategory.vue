<template>
  <div class="d-flex justify-content-center parent-div">
    <cate-edit :category="state.category" @submit="onCategorySubmit" />
  </div>
</template>

<script setup lang="ts">
import cateEdit from '../../components/category/CategoryEdit.vue'
import { getCategory, patchCategory } from '@/services/Category'
import { useRoute, useRouter } from 'vue-router'
import { onMounted, reactive, ref, watch, computed } from 'vue'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'

const route = useRoute()

const state = reactive({
  category: {},
})

onMounted(() => {
  getCategory(+route.params.id).then((response: any) => {
    if (Object.keys(response.data).length > 0) {
      state.category = response.data
      console.log(state.category)
    }
  })
})

const onCategorySubmit = (category: {
  id: number
  title: string
  description: string
  image: File
}) => {
  const formData = new FormData()

  formData.append('title', category.title)
  formData.append('description', category.description)
  if (category.image != null) formData.append('image', category.image)

  patchCategory(category.id, formData).then((response: any) => {
    if (
      response.status === 200 &&
      typeof response.data.category != 'undefined'
    ) {
      toast('Update data sucess', {
        theme: 'colored',
        type: 'success',
        dangerouslyHTMLString: true,
      })
    } else {
      toast('Something is wrong!', {
        theme: 'colored',
        type: 'error',
        dangerouslyHTMLString: true,
      })
    }
  })
}
</script>

<style scoped>
.parent-div {
  height: 77vh;
}
</style>
