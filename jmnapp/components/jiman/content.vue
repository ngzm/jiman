<template>
  <v-row align="stretch">
    <v-col cols="12">
      <TopView :item="value" @onJump="onJump" />
    </v-col>
    <v-col cols="12" md="6">
      <Detail :item="value" />
    </v-col>
    <v-col cols="12" md="6">
      <DetailRating :item="value" @onReview="onReview" />
    </v-col>
    <RatingDialog
      v-model="dialog"
      :title="value.title"
      :review="myReview"
      @onChange="setMyReview"
      @onRegist="registReview"
    />
  </v-row>
</template>

<script>
import { Vue, Component, Prop } from 'nuxt-property-decorator'

import TopView from './content-top-view'
import Detail from './content-detail'
import DetailRating from './content-rating'
import RatingDialog from './content-rating-dialog'

@Component({
  components: {
    TopView,
    Detail,
    DetailRating,
    RatingDialog
  }
})
export default class ContentJiman extends Vue {
  @Prop({ type: Object, required: true }) value

  myReview = { star: 3, comment: '' }
  dialog = false

  onJump() {
    this.upAccess()
    if (process.client) {
      window.open(this.value.url, '_blank')
    }
  }

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
  }

  setMyReview(review) {
    this.myReview.star = review.star
    this.myReview.comment = review.comment
  }

  async upAccess() {
    const data = await this.$axios
      .$post(`${process.env.ENDPOINT_URL}/api/jimen/jump/${this.value.id}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    this.$emit('input', data)
  }

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
</script>
