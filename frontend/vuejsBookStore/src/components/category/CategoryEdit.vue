<template>
  <div>
    <h2>Edit Category</h2>
    <form>
      <label for="name">Category Name:</label>
      <input type="text" id="name" v-model="categoryName" />
      <button type="submit">Save</button>
    </form>
  </div>
</template>

<script setup lang="ts">
const categoryName = defineModel()
</script>
