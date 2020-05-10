import colors from 'vuetify/es5/util/colors'
require('dotenv').config()

export default {
  server: {
    port: 4000, // デフォルト: 3000
    host: 'localhost'
  },
  mode: 'universal',
  /*
   ** Headers of the page
   */
  head: {
    titleTemplate: '%s - ' + process.env.npm_package_name,
    title: process.env.npm_package_name || '',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      {
        hid: 'description',
        name: 'description',
        content: process.env.npm_package_description || ''
      }
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }]
  },
  /*
   ** Customize the progress-bar color
   */
  loading: { color: '#fff' },
  /*
   ** Global CSS
   */
  css: [],
  /*
   ** Plugins to load before mounting the App
   */
  plugins: [
    { src: '~/plugins/axios.js' }
  ],
  /*
   ** Nuxt.js dev-modules
   */
  buildModules: [
    // Doc: https://github.com/nuxt-community/eslint-module
    '@nuxtjs/eslint-module',
    '@nuxtjs/vuetify',
    '@nuxtjs/dotenv'
  ],
  /*
   ** Nuxt.js modules
   */
  modules: [
    // Doc: https://axios.nuxtjs.org/usage
    '@nuxtjs/axios',
    '@nuxtjs/auth'
  ],
  /*
   ** Axios module configuration
   ** See https://axios.nuxtjs.org/options
   */
  axios: {},
  /*
   ** vuetify module configuration
   ** https://github.com/nuxt-community/vuetify-module
   */
  auth: {
    redirect: {
      callback: '/auth/callback',
      login: '/auth/login',
      logout: '/auth/logout',
      home: '/auth/welcome'
    },
    strategies: {
      // local: {
      //   token: {
      //     property: 'token.accessToken'
      //   }
      // },
      // localRefresh: {
      //   scheme: 'refresh',
      //   token: {
      //     property: 'token.accessToken',
      //     maxAge: 15
      //   },
      //   refreshToken: {
      //     property: 'token.refreshToken',
      //     data: 'refreshToken',
      //     maxAge: false
      //   }
      // },
      // auth0: {
      //   domain: 'nuxt-auth.auth0.com',
      //   clientId: 'xxxxxxxxxxxx'
      // },
      // facebook: {
      //   endpoints: {
      //     userInfo: 'https://graph.facebook.com/v2.12/me?fields=about,name,picture{url},email,birthday'
      //   },
      //   clientId: '1111111111111',
      //   scope: ['public_profile', 'email', 'user_birthday']
      // },
      google: {
        client_id: process.env.AUTH_GOOGLE_CLIENT_ID
      }
      // github: {
      //   clientId: process.env.GITHUB_CLIENT_ID,
      //   clientSecret: process.env.GITHUB_CLIENT_SECRET
      // }
      // twitter: {
      //   clientId: 'xxxxxxxxxxxxx'
      // },
    }
  },
  vuetify: {
    customVariables: ['~/assets/variables.scss'],
    theme: {
      dark: true,
      themes: {
        dark: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3
        },
        light: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3
        }
      }
    }
  },
  /*
   ** Build configuration
   */
  build: {
    /*
     ** You can extend webpack config here
     */
    extend(config, ctx) {}
  }
}
