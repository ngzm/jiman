<template>
  <v-btn icon dark :to="toUser">
    <v-avatar v-if="hasPicture" size="32px">
      <img :src="authUser.picture" alt="authUser.name" />
    </v-avatar>
    <v-icon v-else dark>
      mdi-face
    </v-icon>
  </v-btn>
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
    toUser() {
      return `/users/1`
    }
  }
}
</script>
<style></style>
