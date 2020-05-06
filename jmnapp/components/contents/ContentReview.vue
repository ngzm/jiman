<template>
  <v-card height="100%">
    <v-card-text>
      <h5 class="mt-1 subtitle-1 font-weight-bold">詳細ページビューカウント</h5>
      <p class="mt-1 mx-2">{{ item.access }} 回</p>
    </v-card-text>
    <v-card-text>
      <h5 class="subtitle-1 font-weight-bold">お気に入り</h5>
      <v-rating
        v-model="intStar"
        dense
        readonly
        background-color="grey darken-1"
        color="orange"
      />
      <p class="mt-1 mx-2">
        <span v-if="item.star">( {{ intStar }} )</span>
        <span v-else>お気に入りはまだありませんでした</span>
      </p>
    </v-card-text>
    <v-card-actions>
      <v-btn
        color="teal darken-2"
        class="font-weight-bold"
        block
        dark
        @click="$emit('onReview')"
      >
        お気に入りとかコメントを登録する
        <v-icon>mdi-star</v-icon>
      </v-btn>
    </v-card-actions>
    <v-card-text class="pt-4">
      <h5 class="subtitle-1 font-weight-bold">最新コメント</h5>
      <div v-if="item.reviews && item.reviews.length > 0" class="mt-3">
        <v-expansion-panels multiple>
          <v-expansion-panel v-for="(rv, index) in item.reviews" :key="index">
            <v-expansion-panel-header>
              {{ rv.user }}
              <span>
                <v-icon
                  v-for="n in rv.star"
                  :key="n"
                  color="yellow darken-2"
                  class="star"
                >
                  mdi-star
                </v-icon>
              </span>
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              {{ rv.comment }}
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
      </div>
      <p v-else class="mt-3 mx-2">
        コメントはまだありませんでした
      </p>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    item: { default: () => {}, type: Object }
  },
  computed: {
    intStar() {
      return this.item.star ? Math.round(this.item.star) : 0
    },
    formatStar() {
      return this.item.star ? this.item.star.toFixed(2) : 0.0
    }
  }
}
</script>
<style></style>
