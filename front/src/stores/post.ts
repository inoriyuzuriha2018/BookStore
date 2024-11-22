import { defineStore } from 'pinia'
import type { Post } from '@/interfaces/Post'

export const usePostsStore = defineStore({
  id: 'posts',
  state: () => ({
    posts: [] as Post[],
    post: {} as Post,
    total: 5,
  }),
  getters: {
    getComparePublic: state =>
      state.post.is_public == 'public' ? true : false,
    getPost: state => state.post,
    getPosts: state => state.posts,
    getTotal: state => state.total,
  },
  actions: {
    setPosts(listPost: Post[]) {
      this.posts = listPost
    },
    setPost(aPost: Post) {
      this.post = aPost
    },
  },
})
