<script setup lang="ts"></script>
<template>
  <div class="col-lg-10 h-20" id="header">
    <header class="p-0">
      <div class="border rounded card h-25">
        <nav class="navbar navbar-expand-lg d-flex justify-content-between">
          <div>
            <a
              class="navbar-brand"
              href="#eventCollapse"
              data-bs-toggle="collapse"
              aria-controls="eventCollapse"
              role="button"
              style="padding-left: 20px"
              >&#9776;</a
            >
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
