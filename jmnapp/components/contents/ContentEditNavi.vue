<template>
  <v-row justify="end">
    <v-col cols="auto">
      <v-btn class="info font-weight-bold" @click="editJiman">
        投稿を編集する
      </v-btn>
      <v-btn class="indigo darken-4 font-weight-bold">
        投稿を削除する
      </v-btn>
    </v-col>
  </v-row>
</template>
<script>
export default {
  props: {
    id: {
      required: true,
      type: String
    }
  },
  methods: {
    editJiman() {
      this.$router.push(`/useritems/edit/${this.id}`)
    }
  }
}
</script>
