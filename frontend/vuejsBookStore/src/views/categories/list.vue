<template>
  <div class="mt-3 ms-3 me-4">
    <div class="">
      <input
        class="size-checkbox mb-1"
        type="checkbox"
        v-model="state.filter.hasPost"
        aria-label="Checkbox for following text input"
      />
      <label class="form-check-label" for="flexCheckDefault">
        The Posts have public
      </label>
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <button
          class="btn btn-outline-secondary"
          type="button"
          id="basic-addon1"
          @click="performSearch"
        >
          <i class="icon-search"></i>
        </button>
      </div>
      <input
        type="search"
        placeholder="Search for category..."
        v-model="state.filter.title"
        class="mb-0 h-auto form-control"
      />
    </div>
  </div>
  <div>
    <div class="float-start ps-3 mb-3">
      <router-link :to="{ name: 'CategoryNew' }">
        <button class="btn btn-primary">New</button>
      </router-link>
    </div>

    <p class="float-end pe-5" v-if="loading">
      Total Post a Page: {{ computedTotalPostAPage }}
    </p>
  </div>
  <div>
    <div class="d-flex justify-content-center">
      <table class="table table-sm table-bordered table-striped width-table">
        <thead class="thead-dark">
          <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Image</th>
            <th>Count</th>
            <th>Feature</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="category in state.categories"
            :key="category.id"
            :id="'category_' + category.id"
          >
            <td>{{ category.id }}</td>
            <td>{{ category.title }}</td>
            <td>{{ category.description }}</td>
            <td>
              <img
                :src="
                  category.image
                    ? getImageUrl(category.image)
                    : placeholderImage
                "
                class="img-thumbnail"
                :alt="category.title"
                width="50"
                height="50"
              />
            </td>
            <td>{{ category.posts_count }}</td>
            <td style="">
              <router-link
                :to="{ name: 'CategoryEdit', params: { id: category.id } }"
              >
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
        v-model="state.currentPage"
        :page-count="totalPage"
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
import { reactive, ref, watch, computed } from 'vue'
import { getCategories } from '@/services/Category'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'
import Paginate from 'vuejs-paginate-next'
import { useRoute, useRouter } from 'vue-router'
import type { Category } from '@/interfaces/Category'

const router = useRouter()
const route = useRoute()

const loading = ref(false)
const totalPage = ref(3)

// Placeholder image if category.image is not present
const placeholderImage = 'https://via.placeholder.com/50'

const state = reactive({
  categories: [] as Category[],
  filter: {
    title: route.query.title || '',
    hasPost: route.query.hasPost || false,
  },
  currentPage: route.query.page || 1,
  totalPost: 0,
})

const fethCategory = (filter: object) => {
  getCategories(filter)
    .then((response: any) => {
      if (response.data.length > 0) {
        totalPage.value = response.total
        state.categories = response.data
        loading.value = true
      } else {
        toast('No data!')
      }
    })
    .catch(e => {
      console.log(e)
    })
}

watch(
  () => route.query,
  newVal => {
    fethCategory(newVal)
  },
)

const clickCallback = (pageNum: number) => {
  router.push({ query: { ...route.query, page: pageNum } })
}

const performSearch = () => {
  const query = { ...route.query }
  query.title = state.filter.title
  query.has_post = `${state.filter.hasPost}`
  router.push({ query: query })
}

const computedTotalPostAPage = computed(() => {
  return state.categories.reduce(
    (total, category) => total + Number(category.posts_count),
    0,
  )
})

const getImageUrl = (image: string): string => {
  // Modify this logic to suit your API/image handling
  return `${image}`
}

fethCategory({})
</script>
<style lang="scss" scoped>
.width-table {
  width: 97%;
  td,
  th {
    text-align: center;
  }
}

.size-checkbox {
  width: 40px;
  height: 32px;
}
</style>
