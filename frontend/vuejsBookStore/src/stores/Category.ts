import { defineStore } from 'pinia'
import type { Category } from '@/interfaces/Category'

export const useCategoriesStore = defineStore({
  id: 'categories',
  state: () => ({
    categories: [] as Category[],
  }),
  actions: {
    setCategories(listCategories: Category[]) {
      this.categories = listCategories
    },
  },
})
