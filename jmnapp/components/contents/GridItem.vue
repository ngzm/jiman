<template>
  <v-card color="grey darken-2" class="white--text" flat>
    <a href="" @click.stop.prevent="$emit('onSelect')">
      <v-img :src="imgsrc" height="200px" />
    </a>
    <v-card-text class="g-info-container">
      <div class="left">
        <p class="gtitle">{{ item.title }}</p>
      </div>
      <div class="right">
        <v-icon v-for="n in intStar" :key="n" small class="yellow--text">
          mdi-star
        </v-icon>
        <span class="gaccess">{{ item.access }}</span>
      </div>
    </v-card-text>
    <div :class="classGtype">{{ labelGtype }}</div>
  </v-card>
</template>

<script>
export default {
  props: {
    item: {
      required: true,
      type: Object
    }
  },
  computed: {
    intStar() {
      return this.item.star ? Math.round(this.item.star) : 0
    },
    imgsrc() {
      return `${process.env.ENDPOINT_URL}${this.item.image.url}`
    },
    labelGtype() {
      return this.item.gtype === 1
        ? 'HTML5'
        : this.item.gtype === 2
        ? 'FLASH'
        : 'ETC'
    },
    classGtype() {
      return this.item.gtype === 1
        ? 'g-type g-blue'
        : this.item.gtype === 2
        ? 'g-type g-red'
        : 'g-type'
    }
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
.gtitle {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  padding: 0;
  margin: 0;
  color: white;
}
.gaccess {
  margin-left: 1px;
  font-size: 75%;
  color: orange;
}
.gstar {
  font-size: 75%;
}

.g-type {
  position: relative;
  top: -240px;
  left: 8px;
  float: left;
  padding: 4px;
  background-color: rgba(10, 10, 10, 0.25);
  font-size: 75%;
}
.g-red {
  background-color: rgba(90, 0, 0, 0.25);
}
.g-blue {
  background-color: rgba(0, 0, 90, 0.25);
}
</style>
