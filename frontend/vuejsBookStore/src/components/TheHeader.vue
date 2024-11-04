<script setup lang="ts"></script>
<template>
  <div class="col-lg-10 h-20" id="header">
    <header class="p-0">
      <div class="border rounded card h-25 d-inline-block w-100">
        <nav
          class="navbar navbar-expand-lg d-flex justify-content-between mb-0"
        >
          <div></div>
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
