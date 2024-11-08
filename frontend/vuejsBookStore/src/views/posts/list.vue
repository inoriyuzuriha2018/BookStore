<template>
  <div>
    <div class="d-flex justify-content-center">
      <table class="table table-sm table-bordered table-striped width-table">
        <thead class="thead-dark">
          <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Category</th>
            <th>status</th>
            <th>Feature</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="post in getPosts"
            :key="post.id"
            :id="'category_' + post.id"
          >
            <td>{{ post.id }}</td>
            <td>{{ post.title }}</td>
            <td>{{ post.description }}</td>
            <td>{{ post.category?.title }}</td>
            <td>
              <span v-if="post.is_public == 'public'" class="badge bg-success"
                >Public</span
              >
              <span v-else class="badge bg-secondary">Private</span>
            </td>
            <td style="">
              <router-link :to="{ name: 'PostEdit', params: { id: post.id } }">
                <button class="btn btn-info" style="margin-left: 10px">
                  <i class="icon-edit-sign"></i>
                </button>
              </router-link>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div>
      <paginate
        v-model="currentPage"
        :page-count="getTotal"
        :prev-text="'Prev'"
        :next-text="'Next'"
        :container-class="'pagination d-flex justify-content-center'"
        :first-last-button="true"
        :click-handler="clickCallback"
      >
      </paginate>
    </div>
  </div>
</template>
<script setup lang="ts">
import Paginate from 'vuejs-paginate-next'
import { ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { storeToRefs } from 'pinia'
import { usePostsStore } from '../../stores/post'
import { getPostsAPI } from '@/services/Post'

const router = useRouter()
const route = useRoute()
const postsStore = usePostsStore()
// const posts = postsStore.getPosts
// const total = postsStore.getTotal
const { getPosts, getTotal } = storeToRefs(postsStore)
const currentPage = ref(1)

const fetchPosts = (query: object) => {
  getPostsAPI(query)
    .then((response: any) => {
      postsStore.setPosts(response.data)
    })
    .catch(e => console.log(e))
}

watch(
  () => route.query,
  newVal => {
    console.log(newVal)
    fetchPosts(newVal)
  },
)

const clickCallback = (pageNum: number) => {
  router.push({ query: { ...route.query, page: pageNum } })
}

fetchPosts({ page: currentPage.value })
</script>

<style lang="scss" scoped>
.width-table {
  width: 97%;
  td,
  th {
    text-align: center;
  }
}
</style>
