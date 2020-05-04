/* eslint-disable */

export const state = () => ({
  categories: []
})

export const getters = {
  getCategoryById: (state) => (id) => {
    return state.categories.find(ctg => ctg.id == id)
  }
}

export const mutations = {
  setCategories(state, datas) {
    state.categories = datas
  }
}

export const actions = {
  async fetchCategories({ commit }) {
    const datas = await this.$axios
      .$get(`${process.env.ENDPOINT_URL}/api/categories`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    commit('setCategories', datas)
  }
}
