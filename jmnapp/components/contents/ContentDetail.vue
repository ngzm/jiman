<template>
  <v-card height="100%">
    <v-card-text>
      <h5 class="mt-1 subtitle-1 font-weight-bold">これはなんですか？</h5>
      <p class="mt-1 mx-2">{{ item.description }}</p>
    </v-card-text>
    <v-card-text>
      <h5 class="subtitle-1 font-weight-bold">アピールポイント</h5>
      <ol class="mt-1 mx-2">
        <li v-for="(jiman, index) in item.jimans" :key="index">
          {{ jiman }}
        </li>
      </ol>
    </v-card-text>
    <v-card-text>
      <h5 class="subtitle-1 font-weight-bold">カテゴリ</h5>
      <ul class="mt-1 mx-2">
        <li v-for="(ctg, index) in item.categories" :key="index">
          {{ ctg.name }}
        </li>
      </ul>
    </v-card-text>
    <v-card-text>
      <h5 class="subtitle-1 font-weight-bold">登録日</h5>
      <p class="mt-1 mx-2">{{ formatRegister }}</p>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    item: { default: () => {}, type: Object }
  },
  computed: {
    formatRegister() {
      const dt = new Date(this.item.created_at)
      const yy = dt.getFullYear()
      const mm = dt.getMonth() + 1
      const dd = dt.getDate()
      const hh = dt.getHours()
      const ms = dt.getMinutes()
      return `${yy}/${mm}/${dd} ${hh}:${ms}`
    }
  }
}
</script>
<style></style>
