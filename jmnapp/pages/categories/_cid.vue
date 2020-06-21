<template>
  <v-row class="mx-8">
    <v-col cols="12">
      <v-breadcrumbs
        :items="breadItems"
        class="font-weight-bold"
      ></v-breadcrumbs>
      <v-row>
        <v-col
          v-for="item in jimen"
          :key="item.id"
          cols="12"
          sm="6"
          md="4"
          lg="3"
          xl="2"
        >
          <GridItem :item="item" @onSelect="onSelect(item.id)" />
        </v-col>
      </v-row>
    </v-col>
  </v-row>
</template>

<script>
import { Vue, Component } from 'nuxt-property-decorator'
import GridItem from '~/components/jiman/grid-item'

@Component({
  components: { GridItem },
  async asyncData(context) {
    const datas = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/jimen/list/${context.params.cid}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    return datas ? { jimen: datas } : { jimen: [] }
  }
})
export default class CidJimen extends Vue {
  validate({ params }) {
    return /^\d+$/.test(params.cid)
  }

  get cid() {
    return this.$route.params.cid
  }

  get breadItems() {
    return [
      {
        text: 'Home',
        disabled: false,
        to: '/'
      },
      {
        text: this.getCategoryName,
        disabled: true,
        to: `/categories/${this.cid}`
      }
    ]
  }

  get getCategoryName() {
    const category = this.$store.getters.getCategoryById(this.cid)
    return category ? category.name : 'undefined'
  }

  onSelect(id) {
    this.$router.push(`/items/${this.cid}/${id}`)
  }
}
</script>
