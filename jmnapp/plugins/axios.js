export default function ({ app, store, $axios }) {
  const getAuthStrategy = () => {
    return store.state.auth.strategy
  }
  const getAuthUserSub = () => {
    return store.state.auth.user.sub
  }
  $axios.interceptors.request.use(
    (config) => {
      if (store.state.auth.loggedIn) {
        config.headers = {
          ...config.headers,
          'X-AUTH-PROVIDER': getAuthStrategy(),
          'X-AUTH-USER-SUB': getAuthUserSub(),
        }
      }
      return config
    },
    (error) => Promise.reject(error)
  )
}
