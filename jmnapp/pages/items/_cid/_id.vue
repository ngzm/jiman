<template>
  <v-row class="mx-sm-4 mx-md-8 mx-lg-10">
    <v-col cols="12">
      <v-breadcrumbs
        :items="breadItems"
        class="font-weight-bold"
      ></v-breadcrumbs>
      <v-row>
        <v-col cols="12" md="10" xl="9">
          <EditingNav v-if="isMypage" :id="id" />
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
    const data = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/jimen/${context.params.id}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    return { jiman: data }
  }
})
export default class IdJimanItems extends Vue {
  validate({ params }) {
    return /^\d+$/.test(params.cid) && /^\d+$/.test(params.id)
  }

  get jimanValue() {
    return this.jiman
  }

  set jimanValue(value) {
    Object.assign(this.jiman, { ...value })
  }

  get cid() {
    return this.$route.params.cid
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
        text: this.getParentName,
        disabled: false,
        to: `/categories/${this.cid}`
      },
      {
        text: this.jiman.title,
        disabled: true,
        to: `/items/${this.cid}/${this.id}`
      }
    ]
  }

  get isMypage() {
    if (!this.$store.getters.isLogin) return false
    return this.$store.getters.getLoginUser.id === this.jiman.user.id
  }

  get getParentName() {
    const category = this.$store.getters.getCategoryById(this.cid)
    return category ? category.name : 'undefined'
  }
}
</script>
