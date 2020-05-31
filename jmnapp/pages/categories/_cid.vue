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
import GridItem from '~/components/contents/GridItem'

export default {
  components: {
    GridItem
  },
  validate({ params }) {
    return /^\d+$/.test(params.cid)
  },
  async asyncData(context) {
    const datas = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/jimen/list/${context.params.cid}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    return datas ? { jimen: datas } : { jimen: [] }
  },
  computed: {
    cid() {
      return this.$route.params.cid
    },
    breadItems() {
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
    },
    getCategoryName() {
      const category = this.$store.getters.getCategoryById(this.cid)
      return category ? category.name : 'undefined'
    }
  },
  methods: {
    onSelect(id) {
      this.$router.push(`/items/${this.cid}/${id}`)
    }
  }
}
</script>
