<template>
  <div>
    <h1>ログインが必要です。ログインしますか</h1>
    <button @click="githubAuthenticate">GitHub</button>
    <button @click="googleAuthenticate">Google</button>
    <button @click="cancel">戻る</button>
  </div>
</template>

<script>
export default {
  methods: {
    githubAuthenticate() {
      this.$auth.loginWith('github')
    },
    googleAuthenticate() {
      this.$auth.loginWith('google')
    },
    cancel() {
      this.$router.go(-1)
    },
  },
}
</script>
