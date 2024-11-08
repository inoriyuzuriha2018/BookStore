<template>
  <div class="d-flex justify-content-center rounded w-50 m-3 pt-5 theme">
    <form>
      <div class="form-group form mt-3">
        <label for="name">Title</label>
        <input
          type="text"
          id="name"
          class="form-control p-3"
          :class="{
            'is-invalid': state.errors?.title?.length > 0,
          }"
          v-model="state.category.title"
        />
        <div v-if="state.errors?.title?.length" class="invalid-feedback">
          {{ state.errors.title[0] }}
        </div>
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
        <button type="button" @click="submitForm" class="btn btn-primary">
          Save
        </button>
      </div>
    </form>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref, watch } from 'vue'
import type { Category } from '@/interfaces/Category'

const props = defineProps<{
  category: Category
  errors?: Record<string, any>
}>()

const state = reactive({
  category: props.category,
  errors: props.errors,
})

const displayImage = ref()

watch(
  () => props.category,
  newVal => {
    state.category = newVal
    displayImage.value = state.category?.image
  },
)

watch(
  () => props.errors,
  newVal => {
    state.errors = newVal
  },
)

const emit = defineEmits<{
  (e: 'submit', category: Category): void
}>()

const handleFileUpload = (event: Event) => {
  const target = event.target as HTMLInputElement
  const file = target.files?.[0]
  state.category.image = file

  displayImage.value = URL.createObjectURL(file as Blob)
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
