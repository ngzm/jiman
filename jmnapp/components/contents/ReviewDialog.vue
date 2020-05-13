<template>
  <v-dialog v-model="displayme" max-width="680">
    <v-card color="grey darken-3">
      <v-form ref="form" v-model="valid" lazy-validation>
        <v-card-title>
          お気に入りやコメントの登録
        </v-card-title>
        <v-divider />
        <v-card-text>
          <h3 class="subtitle-1">
            {{ authUserName }} さん
            <span class="orange--text">{{ title }}</span> はいかがでしたか？
          </h3>
        </v-card-text>
        <v-card-text>
          <h5 class="subtitle-1">お気に入り度： {{ star }}</h5>
          <v-rating
            v-model="star"
            dense
            background-color="grey"
            color="yellow"
          />
        </v-card-text>
        <v-card-text>
          <h5 class="subtitle-1">よければコメントをお願いします</h5>
          <v-text-field
            v-model="comment"
            :counter="commentSize"
            :rules="commentRules"
            label="コメント"
            textarea
          />
        </v-card-text>
        <v-card-actions class="px-4 pb-4">
          <v-spacer />
          <div>
            <v-btn
              :disabled="!valid"
              dark
              color="blue"
              @click.native="register"
            >
              登録する
            </v-btn>
            <v-btn color="grey" dark @click.native="setDialog(false)">
              やめる
            </v-btn>
          </div>
        </v-card-actions>
      </v-form>
    </v-card>
  </v-dialog>
</template>
<script>
export default {
  props: {
    title: {
      default: '',
      type: String
    },
    review: {
      required: true,
      type: Object
    },
    dialog: {
      required: true,
      type: Boolean
    },
    setDialog: {
      required: true,
      type: Function
    }
  },
  data() {
    return {
      valid: true,
      commentSize: 100,
      commentRules: [
        (v) =>
          v.length <= this.commentSize ||
          `${this.commentSize}文字以内で入力してください`
      ]
    }
  },
  computed: {
    displayme: {
      get() {
        return this.dialog
      },
      set(flg) {
        this.setDialog(flg)
      }
    },
    star: {
      get() {
        return this.review.star || 3
      },
      set(star) {
        this.$emit('onChange', { ...this.review, star })
      }
    },
    comment: {
      get() {
        return this.review.comment || ''
      },
      set(comment) {
        this.$emit('onChange', { ...this.review, comment })
      }
    },
    authUserName() {
      return this.$store.state.auth.user
        ? this.$store.state.auth.user.name
        : '名無し'
    }
  },
  methods: {
    register() {
      if (this.$refs.form.validate()) {
        this.$emit('onRegist')
      }
    }
  }
}
</script>
<style></style>
