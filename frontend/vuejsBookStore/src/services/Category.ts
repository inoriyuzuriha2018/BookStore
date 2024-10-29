import axios from 'axios'

const rootUrl: string = 'http://127.0.0.1:3000';

export async function getUserList(page= 1): Promise<any[]> {
  const pageNumber = page > 1 ?  "?page="+ page : "";
  const response = await axios.get(`${rootUrl}/api/v1/categories` + pageNumber);
  return response.data;
}



export async function getSearchCategory( querySearch: String): Promise<any[]> {
  const response = await axios.get(`${rootUrl}/api/v1/categories/serachCategory` + querySearch);
  return response.data;
}
