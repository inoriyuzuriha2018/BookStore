import type { Post } from '@/interfaces/Post'
import axios from 'axios'

const rootUrl: string = 'http://127.0.0.1:3000'

export async function getPostsAPI(querySearch: object): Promise<any[]> {
  const urlPost: string = '/api/v1/posts'
  const response = await axios.get(`${rootUrl}${urlPost}`, {
    params: querySearch,
  })
  return response.data
}

export async function getPostAPI(id: number): Promise<any[]> {
  const urlPost: string = '/api/v1/posts/' + id
  const response = await axios.get(`${rootUrl}${urlPost}`)
  return response.data
}

export async function patchPostAPI(post: Post): Promise<any> {
  const urlPost: string = '/api/v1/posts/' + post.id
  const response = axios.patch(`${rootUrl}${urlPost}`, post)
  return response
}
