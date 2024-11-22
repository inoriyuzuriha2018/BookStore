<template>
  <div class="border mt-2 card card-body p-0">
    <h2 class="mt-2 d-flex justify-content-center">
      {{ t('name') }}
    </h2>
    <router-view></router-view>
  </div>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'

const { t } = useI18n({
  useScope: 'local',
})
</script>

<style scoped></style>
<i18n lang="json5">
{
  en: {
    name: 'Category Management',
  },
  vi: {
    name: 'Quản lý danh mục',
  },
}
</i18n>
