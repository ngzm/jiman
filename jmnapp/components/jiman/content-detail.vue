<template>
  <v-card color="grey lighten-3" height="100%">
    <v-card-text>
      <v-row align="baseline" justify="start">
        <v-col cols="auto">
          <v-btn icon :to="userPage">
            <v-avatar v-if="isUser" color="grey" size="48">
              <v-img :src="item.user.image" alt="user image" />
            </v-avatar>
          </v-btn>
        </v-col>
        <v-col cols="auto">
          <h4>
            <a @click.stop.prevent="$router.push(userPage)">
              {{ isUser ? item.user.name : '' }} さん
            </a>
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
      <h5 class="subtitle-1 font-weight-bold">登録日</h5>
      <p class="mt-1 mx-2">{{ formatRegister }}</p>
    </v-card-text>
  </v-card>
</template>

<script>
import { Vue, Component, Prop } from 'nuxt-property-decorator'

@Component
export default class ContentDetail extends Vue {
  @Prop({ type: Object, required: true }) item

  get isUser() {
    return this.item && this.item.user
  }

  get userPage() {
    if (!this.isUser) return ''
    return `/users/${this.item.user.id}`
  }

  get formatRegister() {
    const dt = new Date(this.item.created_at)
    const yy = dt.getFullYear()
    const mm = dt.getMonth() + 1
    const dd = dt.getDate()
    const hh = dt.getHours()
    const ms = dt.getMinutes()
    return `${yy}/${mm}/${dd} ${hh}:${ms}`
  }
}
</script>
<style></style>
