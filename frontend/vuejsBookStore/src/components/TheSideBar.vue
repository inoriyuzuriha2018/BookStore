<script setup lang="ts"></script>

<template>
  <div class="wrap col-2 card card-body" id="eventCollapse">
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
            <router-link
              class="nav-link active"
              aria-current="page"
              to="/categories"
            >
              <svg class="bi me-2" width="16" height="16">
                <use xlink:href="#home"></use>
              </svg>
              Category
            </router-link>
          </li>
          <li>
            <a href="#" class="nav-link link-dark">
              <svg class="bi me-2" width="16" height="16">
                <use xlink:href="#speedometer2"></use>
              </svg>
              Dashboard
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<style scoped>
.wrap {
  height: 100vh;
}
</style>
