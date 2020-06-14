<template>
  <v-card height="100%">
    <v-card-text>
      <v-row align="baseline" justify="start">
        <v-col cols="auto">
          <v-btn icon dark @click="$emit('userPage')">
            <v-avatar v-if="userImage" color="grey" size="48">
              <img :src="userImage" alt="user image" />
            </v-avatar>
          </v-btn>
        </v-col>
        <v-col cols="auto">
          <h4>
            <a @click="userPage">{{ userName }} さん</a>
          </h4>
        </v-col>
      </v-row>
    </v-card-text>
    <v-card-text>
      <h5 class="subtitle-1 font-weight-bold">作品について</h5>
      <p class="mx-2">{{ item.description }}</p>
    </v-card-text>
    <v-card-text>
      <h5 class="subtitle-1 font-weight-bold">アピールポイント</h5>
      <ol class="mt-1 mx-2">
        <li>{{ item.point1 }}</li>
        <li v-show="item.point2">{{ item.point2 }}</li>
        <li v-show="item.point3">{{ item.point3 }}</li>
        <li v-show="item.point4">{{ item.point4 }}</li>
        <li v-show="item.point5">{{ item.point5 }}</li>
        <li v-show="item.point6">{{ item.point6 }}</li>
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
      <h5 class="mt-1 subtitle-1 font-weight-bold">詳細ページビューカウント</h5>
      <p class="mt-1 mx-2">{{ item.access }} 回</p>
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
    userName() {
      if (this.item && this.item.user) {
        return this.item.user.name
      }
      return ''
    },
    userImage() {
      if (this.item && this.item.user) {
        return this.item.user.image
      }
      return false
    },
    formatRegister() {
      const dt = new Date(this.item.created_at)
      const yy = dt.getFullYear()
      const mm = dt.getMonth() + 1
      const dd = dt.getDate()
      const hh = dt.getHours()
      const ms = dt.getMinutes()
      return `${yy}/${mm}/${dd} ${hh}:${ms}`
    }
  },
  methods: {
    userPage() {
      if (this.item && this.item.user) {
        this.$router.push(`/users/${this.item.user.id}`)
      }
    }
  }
}
</script>
<style></style>
