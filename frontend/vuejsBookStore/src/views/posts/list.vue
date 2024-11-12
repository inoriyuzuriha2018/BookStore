<template>
  <div>
    <div class="d-flex justify-content-center">
      <table class="table table-sm table-bordered table-striped width-table">
        <thead class="thead-dark">
          <tr>
            <th>{{ t('table.headers.id') }}</th>
            <th>{{ t('table.headers.title') }}</th>
            <th>{{ t('table.headers.description') }}</th>
            <th>{{ t('table.headers.category') }}</th>
            <th>{{ t('table.headers.status') }}</th>
            <th>{{ t('table.headers.feature') }}</th>
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
              <span
                v-if="post.is_public == 'public'"
                class="badge bg-success"
                >{{ t('table.status.public') }}</span
              >
              <span v-else class="badge bg-secondary">{{
                t('table.status.private')
              }}</span>
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
        :prev-text="t('pagination.previous')"
        :next-text="t('pagination.next')"
        :first-button-text="t('pagination.first')"
        :last-button-text="t('pagination.last')"
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
import { useI18n } from 'vue-i18n'

const { t } = useI18n({
  useScope: 'local',
})

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

<i18n lang="json5">
{
  en: {
    table: {
      headers: {
        id: 'ID',
        title: 'Title',
        description: 'Description',
        category: 'Category',
        status: 'Status',
        feature: 'Feature',
      },
      status: {
        public: 'Public',
        private: 'Private',
      },
      buttons: {
        edit: 'Edit',
      },
    },
    pagination: {
      totalPosts: 'Total Post a Page',
      previous: 'Prev',
      next: 'Next',
      first: 'First',
      last: 'Last',
    },
  },
  vi: {
    table: {
      headers: {
        id: 'ID',
        title: 'Tiêu đề',
        description: 'Mô tả',
        category: 'Danh mục',
        status: 'Trạng thái',
        feature: 'Chức năng',
      },
      status: {
        public: 'Công khai',
        private: 'Riêng tư',
      },
      buttons: {
        edit: 'Chỉnh sửa',
      },
    },
    pagination: {
      totalPosts: 'Tổng số bài trên mỗi trang',
      previous: 'Trước',
      next: 'Tiếp',
      first: 'Đầu',
      last: 'cuối',
    },
  },
}
</i18n>
