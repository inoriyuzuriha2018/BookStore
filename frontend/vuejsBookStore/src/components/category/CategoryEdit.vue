<template>
  <div class="d-flex justify-content-center rounded w-50 m-3 pt-5 theme">
    <form @submit.prevent="submitForm">
      <div class="form-group form mt-3">
        <label for="name">Title</label>
        <input
          type="text"
          id="name"
          class="form-control p-3"
          v-model="state.category.title"
        />
      </div>

      <div class="form-group mt-3">
        <label for="name">description:</label>
        <input
          type="text"
          id="name"
          class="form-control p-3"
          v-model="state.category.description"
        />
      </div>

      <div class="form-group mt-3">
        <label for="image" class="form-label">Category Image URL:</label>
        <input
          type="file"
          id="formFile"
          class="form-control pt-0"
          @change="handleFileUpload"
        />
      </div>

      <div v-if="displayImage" class="form-group mt-3">
        <label for="image">Image Preview:</label>
        <img
          :src="displayImage"
          alt="Category Image"
          style="max-width: 100px"
          class="form-control"
        />
      </div>
      <div class="form-group mt-3">
        <button type="submit" class="btn btn-primary">Save</button>
      </div>
    </form>
  </div>
</template>

<script setup lang="ts">
import { onMounted, reactive, ref, watch, computed } from 'vue'

interface Category {
  // Define properties according to the category object structure
  id: number
  title: string
  description: string
  image: Blob
}

const displayImage = ref(new Blob())

const props = defineProps<{
  category: Category
}>()

const state = reactive({
  category: {},
})

const emit = defineEmits<{
  (e: 'submit', category: Category): void
}>()

watch(
  () => props.category,
  newVal => {
    state.category = newVal
    displayImage.value = state.category.image
    state.category.image = null
  },
)

const handleFileUpload = (event: Event) => {
  const target = event.target as HTMLInputElement
  const file = target.files?.[0]
  state.category.image = file
  displayImage.value = URL.createObjectURL(file)
}

const submitForm = () => {
  emit('submit', state.category)
}
</script>

<style scoped>
.theme {
  background-color: #eee;
}
</style>
