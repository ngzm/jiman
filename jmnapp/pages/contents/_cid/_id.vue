<template>
  <v-row class="mx-sm-4 mx-md-8 mx-lg-10">
    <v-col cols="12">
      <v-breadcrumbs :items="breadItems"></v-breadcrumbs>
      <v-row>
        <v-col cols="12" md="11" lg="10" xl="9">
          <ContentDetail
            :content="content"
            @onJump="onJump"
            @onReview="onReview"
          />
        </v-col>
      </v-row>
    </v-col>
  </v-row>
</template>

<script>
import ContentDetail from '~/components/contents/ContentDetail'

export default {
  components: {
    ContentDetail
  },
  validate({ params }) {
    return /^\d+$/.test(params.cid) && /^\d+$/.test(params.id)
  },
  data() {
    return {
      cid: this.$route.params.cid,
      id: this.$route.params.id,
      breadItems: [
        {
          text: 'Home',
          disabled: false,
          to: '/'
        },
        {
          text: `categories- ${this.$route.params.cid}`,
          disabled: false,
          to: `/categories/${this.$route.params.cid}`
        },
        {
          text: `test001-${this.$route.params.id}`,
          disabled: true,
          to: `/contents/${this.cid}/${this.$route.params.id}`
        }
      ],
      content: {
        id: 1,
        title: 'test001',
        description: 'とっても楽しいWebゲームを作成してみました！',
        jimans: [
          'PCやスマホでプレイできる',
          'PCは矢印キーや、マウスでプレイ',
          'PCは WASD でもプレイできる',
          'スマホは、画面の左右をタッチして操作できる'
        ],
        image: '/test/IMG_0301.jpg',
        star: 5,
        access: 200,
        created_at: '2020/05/02 11:30:15'
      }
    }
  },
  methods: {
    onJump() {
      if (process.client) {
        window.open(this.content.url, '_blank')
      }
    },
    onReview() {
      console.log('onReview!!')
    }
  }
}
</script>
