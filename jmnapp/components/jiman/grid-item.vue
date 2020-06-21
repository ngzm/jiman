<template>
  <v-card color="grey darken-2" class="white--text" flat>
    <a @click.stop.prevent="$emit('onSelect')">
      <v-img :src="imgsrc" height="200px" />
    </a>
    <v-card-text class="g-info-container">
      <div class="left">
        <p class="g-info-container-title">{{ item.title }}</p>
      </div>
      <div class="right">
        <v-icon v-for="n in intStar" :key="n" small class="yellow--text">
          mdi-star
        </v-icon>
        <span class="g-info-container-access">{{ item.access }}</span>
      </div>
    </v-card-text>
    <div :class="classGtype">{{ labelGtype }}</div>
  </v-card>
</template>
<script>
import { Vue, Component, Prop } from 'nuxt-property-decorator'

@Component
export default class GridItem extends Vue {
  @Prop({ type: Object, required: true }) item

  get intStar() {
    return this.item.star ? Math.round(this.item.star) : 0
  }

  get imgsrc() {
    return this.item && this.item.image
      ? `${process.env.ENDPOINT_URL}${this.item.image.url}`
      : ''
  }

  get labelGtype() {
    return this.item.gtype === 1
      ? 'HTML5'
      : this.item.gtype === 2
      ? 'FLASH'
      : 'ETC'
  }

  get classGtype() {
    return this.item.gtype === 1
      ? 'g-info-container-type g-info-container-type-blue'
      : this.item.gtype === 2
      ? 'g-info-container-type g-info-container-type-red'
      : 'g-info-container-type'
  }
}
</script>
<style>
.g-info-container {
  display: flex;
}
.g-info-container > .left {
  width: 50%;
}
.g-info-container > .right {
  width: 50%;
  text-align: right;
}
.g-info-container-title {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  padding: 0;
  margin: 0;
  color: white;
}
.g-info-container-access {
  margin-left: 1px;
  font-size: 75%;
  color: orange;
}
.g-info-container-type {
  position: relative;
  top: -240px;
  left: 8px;
  float: left;
  padding: 4px;
  background-color: rgba(10, 10, 10, 0.25);
  font-size: 75%;
}
.g-info-container-type-red {
  background-color: rgba(90, 0, 0, 0.25);
}
.g-info-container-type-blue {
  background-color: rgba(0, 0, 90, 0.25);
}
</style>
