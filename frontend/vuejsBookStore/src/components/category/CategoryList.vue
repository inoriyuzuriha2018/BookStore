<template>
  <div>
    <table class="table table-sm table-striped w-100 p-3">
      <thead class="thead-dark">
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Description</th>
          <th>Image</th>
          <th>Count</th>
          <th>Feature</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="category in categories"
          :key="category.id"
          :id="'category_' + category.id"
        >
          <td>{{ category.id }}</td>
          <td>{{ category.title }}</td>
          <td>{{ category.description }}</td>
          <td>
            <img
              :src="
                category.image ? getImageUrl(category.image) : placeholderImage
              "
              class="img-thumbnail"
              :alt="category.title"
              width="50"
              height="50"
            />
          </td>
          <td>{{ category.posts_count }}</td>
          <td style="">
            <button @click="deleteCategory(category.id)" class="btn btn-danger">
              <i class="icon-trash"></i>
            </button>
            <button
              @click="editCategory(category.id)"
              class="btn btn-info"
              style="margin-left: 10px"
            >
              <i class="icon-edit-sign"></i>
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import  { getUserList } from '@/service/Category'
import { toast } from 'vue3-toastify';
import 'vue3-toastify/dist/index.css';

interface Category {
  id: number
  title: string
  description: string
  image: string | null
  posts_count: number
}

// Placeholder image if category.image is not present
const placeholderImage = 'https://via.placeholder.com/50'

// Example categories data - In a real app, fetch this data from an API
const categories = ref<Category[]>()

onMounted(() => {
  getUserList()
    .then((response: any) => {
      if(response.data.length >0){
        categories.value = response.data;
      }else{
        toast("No data!");
      }
      console.log(  response.data.length);

    });
});



const getImageUrl = (image: string): string => {
  // Modify this logic to suit your API/image handling
  return `/uploads/${image}`
}

const deleteCategory = (id: number): void => {
  if (confirm('Are you sure?')) {
    // Call API to delete the category
    console.log(`Category ${id} deleted.`)
  }
}

const editCategory = (id: number): void => {
  // Navigate to edit category route
  console.log(`Navigate to edit category ${id}`)
}
</script>
