<template>
  <v-row class="mx-8">
    <v-col cols="12">
      <v-breadcrumbs
        :items="breadItems"
        class="font-weight-bold"
      ></v-breadcrumbs>
      <v-row align="baseline" justify="center" class="mb-8">
        <v-col cols="auto">
          <v-avatar v-if="userImage" color="grey" size="160">
            <img :src="userImage" alt="user image" />
          </v-avatar>
        </v-col>
        <v-col cols="auto">
          <p class="title">{{ user ? user.name : '名無し' }} さん</p>
          <p v-if="isMypage">
            {{ user ? user.full_name : 'フルネーム' }}
            <br />
            {{ user ? user.email : 'EMail' }}
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
    const jdata = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/jimen/ulist/${context.params.uid}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    const udata = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/users/${context.params.uid}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    return { jimen: jdata, user: udata }
  },
  computed: {
    uid() {
      return this.$route.params.uid
    },
    userImage() {
      if (this.user.image) {
        return this.user.image
      } else {
        return false
      }
    },
    isMypage() {
      if (this.$store.state.loginUser && this.user) {
        if (this.$store.state.loginUser.id === this.user.id) {
          return true
        }
      }
      return false
    },
    userText() {
      if (this.isMypage) {
        return 'マイページ'
      } else {
        return '作者のページ'
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
          text: `${this.userText}`,
          disabled: true,
          to: `/users/${this.uid}`
        }
      ]
    }
  },
  methods: {
    onSelect(id) {
      this.$router.push(`/useritems/${this.uid}/${id}`)
    }
  }
}
</script>
