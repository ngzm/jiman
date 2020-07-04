<template>
  <div>
    <h1>本当にログアウトしてもよろしいですか</h1>
    <button @click="logout">ログアウトします</button>
    <button @click="cancel">キャンセル</button>
  </div>
</template>

<script>
export default {
  methods: {
    logout() {
      this.$auth.logout()
    },
    cancel() {
      console.log(this.$auth)
      console.log(this.$store.state.auth.user)
      this.$router.go(-1)
    },
  },
}
</script>
