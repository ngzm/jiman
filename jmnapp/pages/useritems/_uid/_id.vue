<template>
  <v-row class="mx-sm-4 mx-md-8 mx-lg-10">
    <v-col cols="12">
      <v-breadcrumbs
        :items="breadItems"
        class="font-weight-bold"
      ></v-breadcrumbs>
      <v-row>
        <v-col cols="12" md="10" xl="9">
          <EditingNav v-if="isMypage" :uid="uid" :id="id" />
          <Content v-model="jimanValue" />
        </v-col>
      </v-row>
    </v-col>
  </v-row>
</template>

<script>
import { Vue, Component } from 'nuxt-property-decorator'
import EditingNav from '~/components/jiman/editing-nav'
import Content from '~/components/jiman/content'

@Component({
  components: {
    EditingNav,
    Content
  },
  async asyncData(context) {
    const jiman = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/jimen/${context.params.id}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    return { jiman }
  },
  validate({ params }) {
    return /^\d+$/.test(params.uid) && /^\d+$/.test(params.id)
  }
})
export default class IdUserItemsJiman extends Vue {
  myReview = { star: 3, comment: '' }
  dialog = false

  get jimanValue() {
    return this.jiman
  }

  set jimanValue(value) {
    Object.assign(this.jiman, { ...value })
  }

  get uid() {
    return this.$route.params.uid
  }

  get id() {
    return this.$route.params.id
  }

  get breadItems() {
    return [
      {
        text: 'Home',
        disabled: false,
        to: '/'
      },
      {
        text: this.isMypage ? 'マイページ' : '作者のページ',
        disabled: false,
        to: `/users/${this.uid}`
      },
      {
        text: this.jiman.title,
        disabled: true,
        to: `/users/${this.uid}/${this.id}`
      }
    ]
  }

  get isMypage() {
    if (!this.$store.getters.isLogin) return false
    return this.$store.getters.getLoginUser.id === this.jiman.user.id
  }
}
</script>
