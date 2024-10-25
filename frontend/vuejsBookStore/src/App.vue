<script setup lang="ts">
import Header from '../src/components/TheHeader.vue'
import SideBar from '../src/components/TheSideBar.vue'

import { onMounted } from 'vue'

onMounted(() => {
  const myCollapsible = document.getElementById('eventCollapse') as HTMLElement
  const headerElement = document.getElementById('header') as HTMLAnchorElement
  myCollapsible.addEventListener('shown.bs.collapse', function () {
    console.log('Shown')
    myCollapsible.classList.add('col-lg-2')
    myCollapsible.classList.remove('d-none')
    headerElement.classList.remove('col-lg-12')
    headerElement.classList.add('col-lg-10')
  })
  myCollapsible.addEventListener('hidden.bs.collapse', function () {
    console.log('Hidden') //d-none
    myCollapsible.classList.remove('col-lg-2')
    myCollapsible.classList.add('d-none')
    headerElement.classList.remove('col-lg-10')
    headerElement.classList.add('col-lg-12')
  })
})
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
