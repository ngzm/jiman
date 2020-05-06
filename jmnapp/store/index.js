export const state = () => ({
  categories: []
})

export const getters = {
  getCategoryById: (state) => (id) => {
    return state.categories.find((ctg) => ctg.id === parseInt(id))
  }
}

export const mutations = {
  SET_CATEGORIES(state, datas) {
    state.categories = datas
  }
}

export const actions = {
  async nuxtServerInit({ commit }) {
    const datas = await this.$axios
      .$get(`${process.env.ENDPOINT_URL}/api/categories`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    console.log(`datas ${datas}`)
    commit('SET_CATEGORIES', datas)
  }
}
