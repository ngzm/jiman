<template>
  <v-snackbar v-model="displayme" :timeout="3000" color="success">
    <span class="font-weight-bold">
      {{ message }}
    </span>
    <v-btn text class="hidden-xs-only font-weight-bold" @click.native="cancel">
      Close
    </v-btn>
  </v-snackbar>
</template>
<script>
export default {
  data() {
    return {
      snackbar: true,
    }
  },
  computed: {
    displayme: {
      get() {
        return this.snackbar && this.authenticated
      },
      set(flg) {
        this.snackbar = flg
      },
    },
    message() {
      if (this.authUser) {
        return `ようこそ ${this.authUser.name} さん`
      } else {
        return 'ログインされていません'
      }
    },
    authenticated() {
      return this.$store.state.auth.loggedIn
    },
    authUser() {
      return this.$store.state.auth.user
    },
  },
  methods: {
    cancel() {
      this.snackbar = false
    },
  },
}
</script>
<style></style>
