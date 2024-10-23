<script setup lang="ts"></script>
<template>
  <header>
    <div>
      <nav class="navbar navbar-expand-lg">
        <div class="container-fluid d-flex justify-content-between">
          <div class="">
            <a class="navbar-brand" href="#">Navbar</a>
          </div>
          <div class="">
            <a class="navbar-brand" href="#">Navbar</a>
          </div>
          <div class="">
            <a class="navbar-brand" href="#">Navbar</a>
          </div>
        </div>
      </nav>
    </div>
  </header>
  <p class="d-inline-flex gap-1">
    <a
      class="btn btn-primary"
      data-bs-toggle="collapse"
      href="#multiCollapseExample1"
      role="button"
      aria-expanded="false"
      aria-controls="multiCollapseExample1"
      >Toggle first element</a
    >
    <button
      class="btn btn-primary"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#"
      aria-expanded="false"
      aria-controls="multiCollapseExample2"
    >
      Toggle second element
    </button>
    <button
      class="btn btn-primary"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target=".multi-collapse"
      aria-expanded="false"
      aria-controls="multiCollapseExample1 multiCollapseExample2"
    >
      Toggle both elements
    </button>
  </p>
  <div class="row">
    <div class="col">
      <div class="collapse multi-collapse" id="multiCollapseExample1">
        <div class="card card-body">
          Some placeholder content for the first collapse component of this
          multi-collapse example. This panel is hidden by default but revealed
          when the user activates the relevant trigger.
        </div>
      </div>
    </div>
    <div class="col">
      <div class="collapse multi-collapse" id="multiCollapseExample2">
        <div class="card card-body">
          Some placeholder content for the second collapse component of this
          multi-collapse example. This panel is hidden by default but revealed
          when the user activates the relevant trigger.
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
header {
  max-width: 100%;
  background-color: #69eeb2;
  padding: 6px;
}

.navbar > .container-fluid {
  justify-content: center;
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
