<template>
  <div>
    <v-row no-gutters>
      <v-col cols="12" class="px-md-4 px-sm-2 xs-1">
        <h4 class="blue--text">入力内容をご確認ください</h4>
      </v-col>
    </v-row>
    <v-row no-gutters justify="end">
      <v-col cols="auto" class="px-md-4 px-sm-2 xs-1">
        <v-btn
          dark
          class="indigo darken-4 font-weight-bold"
          @click="$emit('back')"
        >
          編集に戻る
        </v-btn>
        <v-btn class="info font-weight-bold" @click="$emit('submit')">
          登録する
        </v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" md="6" class="px-md-4 px-sm-2 px-1">
        <v-card class="mt-2">
          <v-card-text class="pt-2">
            <h4>作品イメージ画像</h4>
            <v-img v-if="!!imagesrc" max-height="340" :src="imagesrc" />
          </v-card-text>
          <v-card-text class="pt-4 font-weight-bold">
            <h4>作品タイトル</h4>
            <p class="pa-2 grey darken-2 white--text">{{ jiman.title }}</p>
          </v-card-text>
          <v-card-text class="pt-4 font-weight-bold">
            <h4>作品ページ URL</h4>
            <p class="pa-2 grey darken-2 white--text">{{ jiman.url }}</p>
          </v-card-text>
          <v-card-text class="pt-3 font-weight-bold">
            <h4>作品概要</h4>
            <p class="pa-2 grey darken-2 white--text">
              {{ jiman.description }}
            </p>
          </v-card-text>
        </v-card>
      </v-col>
      <v-col cols="12" md="6" class="px-md-4 px-sm-2 px-1">
        <v-card class="mt-2">
          <v-card-text class="pt-4 font-weight-bold">
            <h4>カテゴリ1</h4>
            <p class="pa-2 grey darken-2 white--text">
              {{ jiman.categories[0].name }}
            </p>
          </v-card-text>
          <v-card-text class="pt-4 font-weight-bold">
            <h4>カテゴリ2</h4>
            <p class="pa-2 grey darken-2 white--text">
              {{
                jiman.categories[1] ? jiman.categories[1].name : '-- 未設定 --'
              }}
            </p>
          </v-card-text>
          <v-card-text class="pt-4 font-weight-bold">
            <h4>カテゴリ3</h4>
            <p class="pa-2 grey darken-2 white--text">
              {{
                jiman.categories[2] ? jiman.categories[2].name : '-- 未設定 --'
              }}
            </p>
          </v-card-text>
          <v-card-text class="pt-3 font-weight-bold">
            <h4>アピールポイント1</h4>
            <p class="pa-2 grey darken-2 white--text">{{ jiman.point1 }}</p>
          </v-card-text>
          <v-card-text class="pt-3 font-weight-bold">
            <h4>アピールポイント2</h4>
            <p class="pa-2 grey darken-2 white--text">
              {{ !!jiman.point2 ? jiman.point2 : '-- 未入力 --' }}
            </p>
          </v-card-text>
          <v-card-text class="pt-3 font-weight-bold">
            <h4>アピールポイント3</h4>
            <p class="pa-2 grey darken-2 white--text">
              {{ !!jiman.point3 ? jiman.point3 : '-- 未入力 --' }}
            </p>
          </v-card-text>
          <v-card-text class="pt-3 font-weight-bold">
            <h4>アピールポイント4</h4>
            <p class="pa-2 grey darken-2 white--text">
              {{ !!jiman.point4 ? jiman.point4 : '-- 未入力 --' }}
            </p>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>
<script>
import { Vue, Component, Prop } from 'nuxt-property-decorator'

@Component
export default class ContentConfirm extends Vue {
  @Prop({ type: Object, required: true }) jiman

  get imagesrc() {
    return this.imagedata ? this.imagedata : this.image
  }

  get image() {
    const image = this.jiman ? this.jiman.image : ''
    if (image && image.url) {
      return `${process.env.ENDPOINT_URL}${image.url}`
    }
    return null
  }

  get imagedata() {
    const imagedata = this.jiman ? this.jiman.imagedata : null
    return imagedata && imagedata.base64data ? imagedata.base64data : null
  }
}
</script>
<style></style>
