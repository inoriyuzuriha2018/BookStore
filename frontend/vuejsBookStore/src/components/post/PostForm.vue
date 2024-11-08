<template>
  <div class="d-flex justify-content-center rounded w-50 m-3 pt-5 theme">
    <form>
      <div class="form-group form mt-3">
        <label for="name">Title</label>
        <input
          type="text"
          id="name"
          class="form-control p-3"
          v-model="newPost.post.title"
        />
      </div>
      <div class="form-group mt-3">
        <label for="name">Description</label>
        <input
          type="text"
          class="form-control p-3"
          v-model="newPost.post.title"
        />
      </div>
      <div class="form-group mt-3 form-check form-switch">
        <input
          type="checkbox"
          id="flexSwitchCheckDefault"
          class="form-check-input"
          true-value="public"
          false-value="unpublic"
          :checked="statusPublic"
          v-model="newPost.post.is_public"
        />
        <label for="checkbox">Status</label>
      </div>
      <div class="form-group mt-3">
        <select
          class="form-select form-select-sm"
          v-model="newPost.post.category_id"
        >
          <option
            v-for="option in categoriesStore.categories"
            :key="option.id"
            :value="option.id"
          >
            {{ option.title }}
          </option>
        </select>
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
import { storeToRefs } from 'pinia'
import { usePostsStore } from '../../stores/post'
import { useCategoriesStore } from '@/stores/Category'
import type { Post } from '@/interfaces/Post'
import { reactive, ref, watch } from 'vue'

const postsStore = usePostsStore()
const categoriesStore = useCategoriesStore()
const allSotre = storeToRefs(postsStore)
const newPost = reactive({
  post: {} as Post,
})
const statusPublic = ref(false)

watch(allSotre.getPost, newVal => {
  newPost.post = newVal
  statusPublic.value = allSotre.getComparePublic.value
})

const emit = defineEmits<{
  (e: 'submit', post: Post): void
}>()

const submitForm = () => {
  emit('submit', newPost.post)
}
</script>

<style lang="scss" scoped>
.theme {
  background-color: #eee;
}
</style>