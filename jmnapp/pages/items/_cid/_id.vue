<template>
  <v-row class="mx-sm-4 mx-md-8 mx-lg-10">
    <v-col cols="12">
      <v-breadcrumbs
        :items="breadItems"
        class="font-weight-bold"
      ></v-breadcrumbs>
      <v-row>
        <v-col cols="12" md="10" xl="9">
          <v-row align="stretch">
            <v-col cols="12">
              <ContentTopView :item="jiman" @onJump="onJump" />
            </v-col>
            <v-col cols="12" md="6">
              <ContentDetail :item="jiman" />
            </v-col>
            <v-col cols="12" md="6">
              <ContentReview :item="jiman" @onReview="onReview" />
            </v-col>
          </v-row>
        </v-col>
      </v-row>
    </v-col>
  </v-row>
</template>

<script>
import ContentTopView from '~/components/contents/ContentTopView'
import ContentDetail from '~/components/contents/ContentDetail'
import ContentReview from '~/components/contents/ContentReview'

export default {
  components: {
    ContentTopView,
    ContentDetail,
    ContentReview
  },
  validate({ params }) {
    return /^\d+$/.test(params.cid) && /^\d+$/.test(params.id)
  },
  async asyncData(context) {
    const data = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/jimen/${context.params.id}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    return data ? { jiman: data } : { jiman: {} }
  },
  data() {
    return {
      cid: this.$route.params.cid,
      id: this.$route.params.id
    }
  },
  computed: {
    breadItems() {
      return [
        {
          text: 'Home',
          disabled: false,
          to: '/'
        },
        {
          text: this.getCategoryName,
          disabled: false,
          to: `/categories/${this.cid}`
        },
        {
          text: this.jiman.title,
          disabled: true,
          to: `/items/${this.cid}/${this.id}`
        }
      ]
    },
    getCategoryName() {
      const category = this.$store.getters.getCategoryById(this.cid)
      return category ? category.name : 'undefined'
    }
  },
  methods: {
    onJump() {
      this.upAccess()
      if (process.client) {
        window.open(this.jiman.url, '_blank')
      }
    },
    onReview() {
      console.log('onReview!!')
    },
    async upAccess() {
      const data = await this.$axios
        .$post(`${process.env.ENDPOINT_URL}/api/jimen/jump/${this.id}`)
        .catch((err) => {
          console.log(`error !! ${err}`)
        })
      this.jiman = data
    }
  }
}
</script>
