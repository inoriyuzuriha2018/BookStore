<template>
  <div class="wrap col-2 card card-body sticky-top" id="eventCollapse">
    <div
      class="d-flex flex-column collapse multi-collapse"
      style="height: 100%"
    >
      <div class="">
        <a
          href="/"
          class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none"
        >
          <svg class="bi me-2" width="40" height="32">
            <use xlink:href="#bootstrap"></use>
          </svg>
          <span class="fs-4">Sidebar</span>
        </a>
        <hr />

        <ul class="nav nav-pills flex-column mb-auto">
          <li class="nav-item">
            <router-link class="nav-link" aria-current="page" to="/categories">
              <svg class="bi me-2" width="16" height="16">
                <use xlink:href="#home"></use>
              </svg>
              {{ t('sidebar.category') }}
            </router-link>

            <router-link class="nav-link" aria-current="page" to="/posts">
              <svg class="bi me-2" width="16" height="16">
                <use xlink:href="#home"></use>
              </svg>
              {{ t('sidebar.Post') }}
            </router-link>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { useI18n } from 'vue-i18n'

const { t } = useI18n({
  useScope: 'local',
})
</script>
<style scoped>
.wrap {
  height: 100vh;
}
</style>
<i18n locale="en" lang="json5">
{
  sidebar: {
    category: 'Category',
    Post: 'Post',
  },
}
</i18n>

<i18n locale="vi" lang="json5">
{
  sidebar: {
    category: 'Danh mục',
    Post: 'Bài viết',
  },
}
</i18n>
