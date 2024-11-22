<script setup lang="ts">
import Header from './components/TheHeader.vue'
import SideBar from './components/TheSideBar.vue'
</script>

<template>
  <div class="wapper container-fluid">
    <div class="row">
      <SideBar />
      <Header />
    </div>
  </div>
</template>

<style scoped>
.wapper {
  align-items: stretch;
}
</style>
