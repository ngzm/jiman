<template>
  <v-row class="mx-8">
    <v-col cols="12">
      <v-row>
        <v-col cols="12">{{ authUser.name }} さんのページ</v-col>
      </v-row>
      <v-row>
        <v-col cols="12">
          <v-avatar v-if="hasPicture" color="grey" size="128">
            <img :src="authUser.picture" alt="authUser.name" />
          </v-avatar>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12">投稿作品</v-col>
      </v-row>
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
    return /^\d+$/.test(params.uid)
  },
  async asyncData(context) {
    const datas = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/jimen/list/${context.params.uid}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    return datas ? { jimen: datas } : { jimen: [] }
  },
  computed: {
    uid() {
      return this.$route.params.uid
    },
    authUser() {
      return this.$store.state.auth.user
    },
    hasPicture() {
      if (this.authUser) {
        return !!this.authUser.picture
      } else {
        return false
      }
    }
  },
  methods: {
    onSelect(id) {
      this.$router.push(`/items/u${this.uid}/${id}`)
    }
  }
}
</script>
