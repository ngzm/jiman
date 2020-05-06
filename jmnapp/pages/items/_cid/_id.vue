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
              <ContentReview
                :item="jiman"
                :reviews="reviews"
                @onReview="onReview"
              />
            </v-col>
          </v-row>
        </v-col>
      </v-row>
      <ReviewDialog
        :dialog="dialog"
        :set-dialog="setDialog"
        :title="jiman.title"
        @onRegist="registReview"
      />
    </v-col>
  </v-row>
</template>

<script>
import ContentTopView from '~/components/contents/ContentTopView'
import ContentDetail from '~/components/contents/ContentDetail'
import ContentReview from '~/components/contents/ContentReview'
import ReviewDialog from '~/components/contents/ReviewDialog'

export default {
  components: {
    ContentTopView,
    ContentDetail,
    ContentReview,
    ReviewDialog
  },
  validate({ params }) {
    return /^\d+$/.test(params.cid) && /^\d+$/.test(params.id)
  },
  async asyncData(context) {
    let jdata = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/jimen/${context.params.id}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    if (!jdata) jdata = {}

    let rdata = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/reviews/list/${context.params.id}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    if (!rdata) rdata = []

    return { jiman: jdata, reviews: rdata }
  },
  data() {
    return {
      cid: this.$route.params.cid,
      id: this.$route.params.id,
      dialog: false
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
    setDialog(flg) {
      this.dialog = flg
    },
    onJump() {
      this.upAccess()
      if (process.client) {
        window.open(this.jiman.url, '_blank')
      }
    },
    onReview() {
      this.setDialog(true)
    },
    async upAccess() {
      const data = await this.$axios
        .$post(`${process.env.ENDPOINT_URL}/api/jimen/jump/${this.id}`)
        .catch((err) => {
          console.log(`error !! ${err}`)
        })
      this.jiman = data
    },
    async registReview(review) {
      await this.$axios
        .$post(`${process.env.ENDPOINT_URL}/api/reviews/${this.id}`, review)
        .catch((err) => {
          console.log(`error !! ${err}`)
        })

      let jdata = await this.$axios
        .$get(`${process.env.ENDPOINT_URL}/api/jimen/${this.id}`)
        .catch((err) => {
          console.log(`error !! ${err}`)
        })
      if (!jdata) jdata = {}
      this.jiman = jdata

      let rdata = await this.$axios
        .$get(`${process.env.ENDPOINT_URL}/api/reviews/list/${this.id}`)
        .catch((err) => {
          console.log(`error !! ${err}`)
        })
      if (!rdata) rdata = []
      this.reviews = rdata
      this.setDialog(false)
    }
  }
}
</script>
