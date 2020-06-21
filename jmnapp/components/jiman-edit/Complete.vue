<template>
  <v-card class="mt-4">
    <v-card-title class="pt-4">
      <h4 class="blue--text">登録完了</h4>
    </v-card-title>
    <v-card-text class="pt-2">
      <h4>{{ jiman.title }} の登録が完了しました。</h4>
    </v-card-text>
    <v-card-actions class="ml-3 pt-3 pb-4">
      <v-btn class="success font-weight-bold" @click="restart">
        登録フォームに戻る
      </v-btn>
    </v-card-actions>
  </v-card>
</template>
<script>
export default {
  props: {
    jiman: {
      required: true,
      type: Object
    }
  },
  methods: {
    restart() {
      this.$emit('onRestart')
    }
  }
}
</script>
<style></style>
