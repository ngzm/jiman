<template>
  <v-row class="mx-sm-4 mx-md-8 mx-lg-10">
    <v-col cols="12">
      <v-breadcrumbs
        :items="breadItems"
        class="font-weight-bold"
      ></v-breadcrumbs>
      <v-row>
        <v-col cols="12" md="10" xl="9">
          <ContentEditNavi v-if="isMypage" :id="id" />
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
        v-model="dialog"
        :title="jiman.title"
        :review="myReview"
        @onChange="setMyReview"
        @onRegist="registReview"
      />
    </v-col>
  </v-row>
</template>

<script>
import ContentEditNavi from '~/components/contents/ContentEditNavi'
import ContentTopView from '~/components/contents/ContentTopView'
import ContentDetail from '~/components/contents/ContentDetail'
import ContentReview from '~/components/contents/ContentReview'
import ReviewDialog from '~/components/contents/ReviewDialog'

export default {
  components: {
    ContentEditNavi,
    ContentTopView,
    ContentDetail,
    ContentReview,
    ReviewDialog
  },
  validate({ params }) {
    return /^\d+$/.test(params.uid) && /^\d+$/.test(params.id)
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
      myReview: { star: 3, comment: '' },
      dialog: false
    }
  },
  computed: {
    uid() {
      return this.$route.params.uid
    },
    id() {
      return this.$route.params.id
    },
    breadItems() {
      return [
        {
          text: 'Home',
          disabled: false,
          to: '/'
        },
        {
          text: this.getParentName,
          disabled: false,
          to: `/users/${this.uid}`
        },
        {
          text: this.jiman.title,
          disabled: true,
          to: `/useritems/${this.uid}/${this.id}`
        }
      ]
    },
    isMypage() {
      if (
        this.$store.state.auth.loggedIn &&
        this.$store.state.loginUser &&
        this.jiman.user
      ) {
        if (this.$store.state.loginUser.id === this.jiman.user.id) {
          return true
        }
      }
      return false
    },
    getParentName() {
      if (this.isMypage) {
        return 'マイページ'
      } else {
        return '作者のページ'
      }
    }
  },
  methods: {
    onJump() {
      this.upAccess()
      if (process.client) {
        window.open(this.jiman.url, '_blank')
      }
    },
    async upAccess() {
      const data = await this.$axios
        .$post(`${process.env.ENDPOINT_URL}/api/jimen/jump/${this.id}`)
        .catch((err) => {
          console.log(`error !! ${err}`)
        })
      this.jiman = data
    },
    async onReview() {
      if (this.$store.state.auth.loggedIn) {
        this.myReview = { star: 3, comment: '' }
        const review = await this.$axios
          .$get(`${process.env.ENDPOINT_URL}/api/reviews/show/${this.id}`)
          .catch((err) => {
            console.log(`error !! ${err}`)
          })
        if (review) {
          this.myReview = { star: review.star, comment: review.comment }
        }
        this.dialog = true
      } else {
        this.$auth.redirect('login')
      }
    },
    setMyReview(review) {
      this.myReview.star = review.star
      this.myReview.comment = review.comment
    },
    async registReview() {
      await this.$axios
        .$post(
          `${process.env.ENDPOINT_URL}/api/reviews/${this.id}`,
          this.myReview
        )
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
      this.dialog = false
    }
  }
}
</script>
