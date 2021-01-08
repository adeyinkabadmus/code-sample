import { Endpoint } from '../config/endpoints'
import axiosInstance from './http.instance'

export default class Property {
  /**
   * sends request to api to create a
   * new property
   *
   * @param {object} payload
   * @return {Promise<AxiosInstance>}
   */
  create (payload) {
    let url = `${Endpoint.createProperty}`
    return axiosInstance.post(url, payload)
  }

  /**
   * sends request to api to retrieve properties
   * page after page
   *
   * @param {number} page
   * @return {Promise<AxiosInstance>}
   */
  fetchAll (page) {
    let url = `${Endpoint.fetchProperties}?page=${page}`
    return axiosInstance.get(url)
  }

  /**
   * sends request to api to retrieve full property
   * statistics
   *
   * @param {number} id
   * @return {Promise<AxiosInstance>}
   */
  fetchOne (id) {
    let url = `${Endpoint.fetchProperty}?id=${id}`
    return axiosInstance.get(url)
  }

  /**
   * sends api request to update a property
   * information
   * @param {object} payload 
   * @return {Promise<AxiosInstance>}
   */
  update (payload) {
    let url = `${Endpoint.updateProperty}`
    return axiosInstance.put(url, payload)
  }
}