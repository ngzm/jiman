<template>
  <div>
    <v-card>
      <a href="" @click.stop.prevent="$emit('onJump')">
        <v-img :src="content.image" min-height="300px" max-height="580px" />
      </a>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn
          color="red darken-4"
          block
          dark
          class="font-weight-bold"
          @click="$emit('onJump')"
        >
          詳細はこちら
          <v-icon>mdi-play</v-icon>
        </v-btn>
      </v-card-actions>
      <v-card-text class="mt-4">
        <h5 class="title font-weight-bold">{{ content.title }}</h5>
        <p class="mt-1 ml-2">{{ content.description }}</p>
      </v-card-text>
      <v-card-text>
        <h5 class="title font-weight-bold">ジマンポイント</h5>
        <ol class="mt-1 ml-2">
          <li v-for="(jiman, index) in content.jimans" :key="index">
            {{ jiman }}
          </li>
        </ol>
      </v-card-text>
      <v-card-text>
        <h5 class="title font-weight-bold">登録日</h5>
        <p class="mt-1 ml-2">{{ formatRegister }}</p>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
export default {
  props: {
    content: { default: () => {}, type: Object }
  },
  computed: {
    formatRegister() {
      const dt = new Date(this.content.created_at)
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
