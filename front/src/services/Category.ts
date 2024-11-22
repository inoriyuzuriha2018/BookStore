import axios from 'axios'

const rootUrl: string = 'http://127.0.0.1:3000'

export async function getCategories(querySearch: object): Promise<any[]> {
  const response = await axios.get(`${rootUrl}/api/v1/categories`, {
    params: querySearch,
  })
  return response.data
}

export async function getCategory(id: number): Promise<any[]> {
  const response = await axios.get(`${rootUrl}/api/v1/categories/` + id)
  return response.data
}

export async function patchCategory(id: number, form: object): Promise<any> {
  const response = await axios({
    method: 'patch',
    url: `${rootUrl}/api/v1/categories/` + id,
    data: form,
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  })
  return response
}

export async function createCategory(form: object): Promise<any> {
  const response = await axios({
    method: 'post',
    url: `${rootUrl}/api/v1/categories/`,
    data: form,
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  })
  return response
}
