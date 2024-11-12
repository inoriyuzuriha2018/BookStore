<template>
  <div class="col-lg-10 h-20" id="header">
    <header class="p-0">
      <div class="border rounded card h-25 d-inline-block w-100">
        <nav
          class="navbar navbar-expand-lg d-flex justify-content-between mb-0"
        >
          <div>
            <form class="navbar-brand ps-2 pt-3">
              <select v-model="$i18n.locale" id="locale">
                <option
                  v-for="locale in $i18n.availableLocales"
                  :value="locale"
                  :key="locale"
                >
                  {{ locale }}
                </option>
              </select>
            </form>
          </div>
          <div class="">
            <a class="navbar-brand" href="#">Navbar3</a>
          </div>
        </nav>
      </div>
    </header>
    <RouterView />
  </div>
</template>

<style scoped>
.h-20 {
  height: 20%;
}
header {
  padding: 6px;
}

nav ul li a {
  color: white;
  text-decoration: none;
  font-weight: bold;
}

nav ul li a:hover {
  text-decoration: underline;
}
</style>
<script setup lang="ts">
import { watch } from 'vue'
import { useI18n } from 'vue-i18n'

const { locale } = useI18n()

watch(locale, () => {
  localStorage.setItem('last-locale', locale.value)
  console.log('locale', locale.value)
})
</script>
