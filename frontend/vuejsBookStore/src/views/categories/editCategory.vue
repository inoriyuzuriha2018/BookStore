<template>
  <div class="d-flex justify-content-center parent-div">
    <cate-edit v-bind="state" @submit="onCategorySubmit" />
  </div>
</template>

<script setup lang="ts">
import cateEdit from '../../components/category/CategoryForm.vue'
import { getCategory, patchCategory } from '@/services/Category'
import { useRoute, useRouter } from 'vue-router'
import { onMounted, reactive, ref, watch, computed } from 'vue'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'

const route = useRoute()

const computedInitDefaultErrors = computed(() => {
  return {
    title: [],
    description: [],
    image: '',
  }
})

const computedInitDefaultCategory = computed(() => {
  return {
    title: '',
    description: '',
    image: '',
  }
})

const state = reactive({
  category: computedInitDefaultCategory.value,
  errors: computedInitDefaultErrors.value,
})

const betweenStatus = x => {
  const sucess = [200, 299]
  return x >= sucess[0] && x <= sucess[1]
}

onMounted(() => {
  getCategory(+route.params.id).then((response: any) => {
    if (Object.keys(response.data).length > 0) {
      state.category = response.data
    }
  })
})

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
  if (category.image != null) formData.append('image', category.image)

  patchCategory(category.id, formData).then((response: any) => {
    if (betweenStatus(response.status)) {
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
  height: 90vh;
}
</style>
