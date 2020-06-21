<template>
  <v-row class="mx-8">
    <v-col cols="12">
      <v-breadcrumbs
        :items="breadItems"
        class="font-weight-bold"
      ></v-breadcrumbs>
      <v-row align="baseline" justify="center" class="mb-8">
        <v-col cols="auto">
          <v-avatar v-if="isUser" color="grey" size="160">
            <img :src="userJimen.user.image" alt="user image" />
          </v-avatar>
        </v-col>
        <v-col cols="auto">
          <p class="title">
            {{ isUser ? userJimen.user.name : '名無し' }} さん
          </p>
          <p v-if="isMypage">
            {{ isUser ? userJimen.user.full_name : 'フルネーム' }}
            <br />
            {{ isUser ? userJimen.user.email : 'EMail' }}
          </p>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="auto">
          <h4>投稿リスト</h4>
        </v-col>
      </v-row>
      <v-row>
        <v-col
          v-for="item in userJimen.jimen"
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
    const data = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/jimen/ulist/${context.params.uid}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    return data ? { userJimen: data } : { userJimen: [] }
  }
})
export default class UidJimen extends Vue {
  validate({ params }) {
    return /^\d+$/.test(params.uid)
  }

  get uid() {
    return this.$route.params.uid
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
        disabled: true,
        to: `/users/${this.uid}`
      }
    ]
  }

  get isMypage() {
    if (!this.$store.getters.isLogin) return false
    return this.$store.getters.getLoginUser.id === this.userJimen.user.id
  }

  get isUser() {
    return this.userJimen && this.userJimen.user
  }

  onSelect(id) {
    this.$router.push(`/useritems/${this.uid}/${id}`)
  }
}
</script>
