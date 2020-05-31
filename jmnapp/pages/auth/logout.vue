<template>
  <div>
    You have been signed out!
    <button @click="showUser">Show</button>
  </div>
</template>

<script>
export default {
  middleware: ['auth'],
  options: {
    auth: false
  },
  methods: {
    showUser() {
      console.log(this.$store.state.auth)
    }
  }
}
</script>
