export const state = () => ({
  categories: []
})

export const getters = {
  getCategoryById: (state) => (id) => {
    if (state.categories) {
      return state.categories.find((ctg) => ctg.id === parseInt(id))
    } else {
      return 'undefined'
    }
  }
}

export const mutations = {
  SET_CATEGORIES(state, datas) {
    Object.assign(state.categories, datas)
  }
}

export const actions = {
  async nuxtServerInit({ commit }) {
    const datas = await this.$axios
      .$get(`${process.env.ENDPOINT_URL}/api/categories`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    commit('SET_CATEGORIES', datas)
  }
}
