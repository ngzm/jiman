<template>
  <v-row class="mx-8">
    <v-col cols="12">
      <v-breadcrumbs
        :items="breadItems"
        class="font-weight-bold"
      ></v-breadcrumbs>
      <v-row align="baseline" justify="center" class="mb-8">
        <v-col cols="auto">
          <v-avatar v-if="hasPicture" color="grey" size="160">
            <img :src="authUser.picture" alt="authUserName" />
          </v-avatar>
        </v-col>
        <v-col cols="auto">
          <h4>{{ authUserName }} さん</h4>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="auto">
          <h4>投稿リスト</h4>
        </v-col>
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
    authUserName() {
      return this.$store.state.auth.user.given_name
    },
    hasPicture() {
      if (this.authUser) {
        return !!this.authUser.picture
      } else {
        return false
      }
    },
    breadItems() {
      return [
        {
          text: 'Home',
          disabled: false,
          to: '/'
        },
        {
          text: '作者のページ',
          disabled: true,
          to: `/users/${this.uid}`
        }
      ]
    }
  },
  methods: {
    onSelect(id) {
      this.$router.push(`/items/u${this.uid}/${id}`)
    }
  }
}
</script>
