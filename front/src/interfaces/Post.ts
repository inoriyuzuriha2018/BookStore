import type { Category } from './Category'

export interface Post {
  id: number
  title: string
  description: string
  is_public: string
  category?: Category
}
