<template>
  <v-menu bottom left offset-y>
    <template v-slot:activator="{ on }">
      <v-btn icon dark v-on="on">
        <v-avatar v-if="hasPicture" size="32px">
          <img :src="authUser.picture" alt="authUser.name" />
        </v-avatar>
        <v-icon v-else dark>
          mdi-face
        </v-icon>
      </v-btn>
    </template>
    <v-list dense>
      <v-list-item :to="toUser">
        <v-list-item-action>
          <v-icon>mdi-text-box-multiple-outline</v-icon>
        </v-list-item-action>
        <v-list-item-content>
          <v-list-item-title>マイページ</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item :to="toUserNew">
        <v-list-item-action>
          <v-icon>mdi-text-box-multiple-outline</v-icon>
        </v-list-item-action>
        <v-list-item-content>
          <v-list-item-title>Jimman を登録する</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item to="/">
        <v-list-item-action>
          <v-icon>mdi-account-box</v-icon>
        </v-list-item-action>
        <v-list-item-content>
          <v-list-item-title>アカウント情報</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item @click.stop.prevent="logout">
        <v-list-item-action>
          <v-icon>mdi-account-outline</v-icon>
        </v-list-item-action>
        <v-list-item-content>
          <v-list-item-title>ログアウト</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-menu>
</template>
<script>
export default {
  computed: {
    authUser() {
      return this.$store.state.auth.user
    },
    hasPicture() {
      if (this.authUser) {
        return !!this.authUser.picture
      } else {
        return false
      }
    },
    toUserNew() {
      if (this.authUser && this.$store.state.loginUser)
        return `/useritems/${this.$store.state.loginUser.id}/edit/new`
      else {
        return '/'
      }
    },
    toUser() {
      if (this.authUser && this.$store.state.loginUser)
        return `/users/${this.$store.state.loginUser.id}`
      else {
        return '/'
      }
    },
  },
  methods: {
    logout() {
      this.$router.push('/auth/logoutconfirm')
    },
  },
}
</script>
<style></style>
