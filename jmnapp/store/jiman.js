const defaultJiman = () => {
  return {
    jiman: {
      title: '',
      description: '',
      image: { url: null },
      url: '',
      point1: '',
      point2: '',
      point3: '',
      point4: '',
      categories: [],
      imagedata: { name: '', type: ``, base64data: null },
    },
  }
}
const defaultImagedata = () => {
  return { imagedata: { name: '', type: ``, base64data: null } }
}
const sendData = (jiman) => {
  const sdata = {
    title: jiman.title,
    description: jiman.description,
    url: jiman.url,
    point1: jiman.point1,
    point2: jiman.point2,
    point3: jiman.point3,
    point4: jiman.point4,
    categories: jiman.categories,
  }
  if (jiman.imagedata && jiman.imagedata.base64data) {
    sdata.imagedata = {
      name: jiman.imagedata.name,
      type: jiman.imagedata.type,
      base64data: jiman.imagedata.base64data.split(',')[1],
    }
  }
  return sdata
}

export const state = defaultJiman

export const mutations = {
  SET_JIMAN(state, jdata) {
    Object.assign(state.jiman, jdata)
  },
  CLEAR_JIMAN(state) {
    Object.assign(state, defaultJiman())
  },
}

export const actions = {
  async fetchJiman({ commit }, id) {
    const jdata = await this.$axios
      .$get(`${process.env.ENDPOINT_URL}/api/jimen/${id}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    Object.assign(jdata, defaultImagedata())
    commit('SET_JIMAN', jdata)
  },
  async updateJiman({ state, commit }, id) {
    await this.$axios
      .$put(
        `${process.env.ENDPOINT_URL}/api/jimen/${id}`,
        sendData(state.jiman)
      )
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
  },
  async createJiman({ state, commit }) {
    await this.$axios
      .$post(`${process.env.ENDPOINT_URL}/api/jimen`, sendData(state.jiman))
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
  },
}
