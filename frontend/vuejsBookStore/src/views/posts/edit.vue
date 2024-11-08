<template>
  <div class="d-flex justify-content-center parent-div">
    <post-form @submit="onPostSubmit" />
  </div>
</template>
<script setup lang="ts">
import { usePostsStore } from '@/stores/post'
import { useCategoriesStore } from '@/stores/Category'
import PostForm from '../../components/post/PostForm.vue'
import { useRoute, useRouter } from 'vue-router'
import { getCategories } from '@/services/Category'
import { getPostAPI, patchPostAPI } from '@/services/Post'
import type { Post } from '@/interfaces/Post'

const route = useRoute()
const router = useRouter()
const postsStore = usePostsStore()
const categoriesStore = useCategoriesStore()

Promise.all([
  getPostAPI(+route.params.id) as any,
  getCategories({}) as any, //
])
  .then(([postResponse, categoriesResponse]) => {
    postsStore.setPost(postResponse.data)
    categoriesStore.setCategories(categoriesResponse.data)
  })
  .catch(e => {
    console.log(e)
  })
const onPostSubmit = (post: Post) => {
  patchPostAPI(post)
    .then(() => {
      router.push({ name: 'PostList' })
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
