<template>
  <v-card class="mt-2">
    <v-card-title class="pt-4 blue--text subtitle-1 font-weight-bold">
      入力内容をご確認ください
    </v-card-title>
    <v-card-text class="pt-2">
      <h4>作品イメージ画像</h4>
      <v-img v-if="!!jiman.imgdata" max-height="340" :src="jiman.imgdata">
        <v-row
          v-if="!!jiman.file"
          align="end"
          class="lightbox white--text px-10 fill-height"
        >
          <v-col>
            <div class="filetitle subheading pa-2">{{ jiman.file.name }}</div>
          </v-col>
        </v-row>
      </v-img>
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
      <p class="pa-2 grey darken-2 white--text">{{ jiman.description }}</p>
    </v-card-text>
    <v-card-text class="pt-3 font-weight-bold">
      <h4>アピールポイント1</h4>
      <p class="pa-2 grey darken-2 white--text">{{ jiman.point1 }}</p>
    </v-card-text>
    <v-card-text class="pt-3 font-weight-bold">
      <h4>アピールポイント2</h4>
      <p class="pa-2 grey darken-2 white--text">
        {{ !!jiman.point2 ? jiman.point2 : '未入力' }}
      </p>
    </v-card-text>
    <v-card-text class="pt-3 font-weight-bold">
      <h4>アピールポイント3</h4>
      <p class="pa-2 grey darken-2 white--text">
        {{ !!jiman.point3 ? jiman.point3 : '未入力' }}
      </p>
    </v-card-text>
    <v-card-text class="pt-3 font-weight-bold">
      <h4>アピールポイント4</h4>
      <p class="pa-2 grey darken-2 white--text">
        {{ !!jiman.point4 ? jiman.point4 : '未入力' }}
      </p>
    </v-card-text>
    <v-card-actions class="ml-3 pt-3 pb-4">
      <v-btn class="info font-weight-bold" @click="submit">
        送信
      </v-btn>
      <v-btn class="warning font-weight-bold" @click="back">
        戻る
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
    submit() {
      this.$emit('onSubmit')
    },
    back() {
      this.$emit('onBack')
    }
  }
}
</script>
<style></style>
