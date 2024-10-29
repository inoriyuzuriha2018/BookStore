<template>
  <div>
    <div class="input-group input-group-sm mb-3">
      <div class="input-group-prepend">
        <button
          class="btn btn-outline-secondary"
          type="button"
          @click="performSearch"
        >
          <i class="icon-search"></i>
        </button>
        <div class="input-group-text">
          <input
            type="checkbox"
            v-model="state.filter.hasPost"
            aria-label="Checkbox for following text input"
          />
        </div>
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
    <p v-if="loading">Total Post a Page: {{ computedTotalPostAPage }}</p>
  </div>
  <div>
    <table class="table table-sm table-striped w-100 p-3">
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
                category.image ? getImageUrl(category.image) : placeholderImage
              "
              class="img-thumbnail"
              :alt="category.title"
              width="50"
              height="50"
            />
          </td>
          <td>{{ category.posts_count }}</td>
          <td style="">
            <button @click="deleteCategory(category.id)" class="btn btn-danger">
              <i class="icon-trash"></i>
            </button>
            <button
              @click="editCategory(category.id)"
              class="btn btn-info"
              style="margin-left: 10px"
            >
              <i class="icon-edit-sign"></i>
            </button>
          </td>
        </tr>
      </tbody>
    </table>
    <div>
      <paginate
        v-model="state.currentPage"
        :page-count="totalPage"
        :prev-text="'Prev'"
        :next-text="'Next'"
        :container-class="'pagination'"
        :first-last-button="true"
        :click-handler="clickCallback"
      >
      </paginate>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, reactive, ref, watch, computed } from 'vue'
import { getSearchCategories, getUserList } from '@/services/Category'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'
import Paginate from 'vuejs-paginate-next'
import { useRoute, useRouter } from 'vue-router'

interface Category {
  id: number
  title: string
  description: string
  image: string | null
  posts_count: number
}

const router = useRouter()
const route = useRoute()

const loading = ref(false)
const totalPage = ref(3)

// Placeholder image if category.image is not present
const placeholderImage = 'https://via.placeholder.com/50'

const state = reactive({
  categories: [],
  filter: {
    title: route.query.title || '',
    hasPost: route.query.hasPost || false,
  },
  currentPage: route.query.page || 1,
  totalPost: 0,
})

onMounted(() => {
  getUserList(state.currentPage).then((response: any) => {
    if (response.data.length > 0) {
      totalPage.value = response.total
      state.categories = response.data
      loading.value = true
    } else {
      toast('No data!')
    }
    //console.log(  response.data.length);
  })
})

watch(
  () => route.query,
  (newVal, oldVal) => {
    const queryCurrent = window.location.search
    searchText(queryCurrent)
  },
)

const clickCallback = (pageNum: number) => {
  router.push({ query: { ...route.query, page: pageNum } })
}

const performSearch = () => {
  const query = {
    ...router.query,
  }
  if (state.filter.title.length > 0) {
    Object.defineProperty(query, 'title', {
      value: state.filter.title,
      writable: true, // Có thể chỉnh sửa
      enumerable: true, // Được liệt kê trong vòng lặp
      configurable: true, // Có thể xóa hoặc thay đổi thuộc tính
    })
  }
  if (state.filter.hasPost) {
    Object.defineProperty(query, 'hasPost', {
      value: state.filter.hasPost,
      writable: true, // Có thể chỉnh sửa
      enumerable: true, // Được liệt kê trong vòng lặp
      configurable: true, // Có thể xóa hoặc thay đổi thuộc tính
    })
  }
  console.log(query)
  router.push({ query: query })
}

const searchText = (query: string): void => {
  getSearchCategories(query).then((response: any) => {
    if (response.data.length > 0) {
      totalPage.value = response.total
      state.categories = response.data
    } else {
      if (response.total < route.query.page) {
        router.push({ query: { title: state.filter.title, page: 1 } })
      }
    }
    //console.log(  response.data.length);
  })
}

const computedTotalPostAPage = computed(() => {
  return state.categories.reduce(
    (total, category) => total + category.posts_count,
    0,
  )
  // console.log(state.categories.reduce((total, category) => total + category.posts_count, 0))
})

const getImageUrl = (image: string): string => {
  // Modify this logic to suit your API/image handling
  return `/uploads/${image}`
}

const deleteCategory = (id: number): void => {
  if (confirm('Are you sure?')) {
    // Call API to delete the category
    console.log(`Category ${id} deleted.`)
  }
}

const editCategory = (id: number): void => {
  // Navigate to edit category route
  router.push({ name: 'CategoryEdit', params: { id: id } })
}
</script>
