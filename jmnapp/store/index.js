export const state = () => ({
  categories: [],
  loginUser: {}
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
  SET_CATEGORIES(state, data) {
    Object.assign(state.categories, data)
  },
  SET_LOGIN_USER(state, data) {
    Object.assign(state.loginUser, data)
    console.log('state loginUser')
    console.log(state.loginUser)
  }
}

export const actions = {
  async nuxtServerInit({ commit }) {
    const categories = await this.$axios
      .$get(`${process.env.ENDPOINT_URL}/api/categories`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    commit('SET_CATEGORIES', categories)

    const user = await this.$axios
      .$get(`${process.env.ENDPOINT_URL}/api/autheduser`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    commit('SET_LOGIN_USER', user)
  }
}
