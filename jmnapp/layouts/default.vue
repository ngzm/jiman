<template>
  <v-app dark>
    <v-navigation-drawer
      v-model="drawer"
      :mini-variant="miniVariant"
      :clipped="clipped"
      fixed
      app
    >
      <CategoryList />
    </v-navigation-drawer>
    <v-app-bar :clipped-left="clipped" fixed app>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-btn icon @click.stop="miniVariant = !miniVariant">
        <v-icon>mdi-{{ `chevron-${miniVariant ? 'right' : 'left'}` }}</v-icon>
      </v-btn>
      <v-toolbar-title v-text="title" />
      <v-spacer />
      <!-- User Menu -->
      <UserMenu v-if="authenticated" />
      <!-- Right Menu -->
      <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
      </v-btn>
    </v-app-bar>
    <v-content>
      <v-container fluid>
        <nuxt />
      </v-container>
    </v-content>
    <WelcomeBar />
  </v-app>
</template>

<script>
import CategoryList from '~/components/frames/CategoryList'
import UserMenu from '~/components/frames/UserMenu'
import WelcomeBar from '~/components/frames/WelcomeBar'

export default {
  components: {
    CategoryList,
    UserMenu,
    WelcomeBar
  },
  data() {
    return {
      clipped: true,
      drawer: true,
      fixed: false,
      miniVariant: false,
      title: 'Vuetify.js'
    }
  },
  computed: {
    authenticated() {
      console.log(this.$store.state.auth)
      return this.$store.state.auth.loggedIn
    }
  }
}
</script>
