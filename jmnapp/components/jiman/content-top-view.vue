<template>
  <v-card>
    <template v-if="item.url">
      <a href="" class="titlelink" @click.stop.prevent="$emit('jump')">
        <v-img :src="imgsrc" min-height="300px" max-height="580px">
          <v-row
            align="center"
            justify="center"
            class="white--text pa-6 fill-height"
          >
            <v-col cols="10" sm="8" md="6" lg="6" xl="6">
              <div class="itemtitle pa-4 headline font-weight-bold">
                {{ item.title }}
              </div>
            </v-col>
          </v-row>
        </v-img>
      </a>
      <v-card-actions>
        <v-btn
          color="red darken-4"
          block
          dark
          class="font-weight-bold"
          @click="$emit('onJump')"
        >
          詳細ページをみる
          <v-icon>mdi-play</v-icon>
        </v-btn>
      </v-card-actions>
    </template>
    <template v-else>
      <v-img :src="item.image" min-height="300px" max-height="580px" />
    </template>
  </v-card>
</template>

<script>
import { Vue, Component, Prop } from 'nuxt-property-decorator'

@Component({})
export default class ContentTopView extends Vue {
  @Prop({ type: Object, required: true }) item

  get imgsrc() {
    return this.item.image
      ? `${process.env.ENDPOINT_URL}${this.item.image.url}`
      : ''
  }
}
</script>
<style>
.titlelink {
  text-decoration: none !important;
}
.itemtitle {
  text-align: center;
  background-color: rgba(0, 0, 0, 0.5);
}
</style>
