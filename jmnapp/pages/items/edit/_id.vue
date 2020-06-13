<template>
  <v-row class="mx-sm-6 mx-2">
    <v-col cols="12">
      <h4>作品情報変更</h4>
      <v-row>
        <v-col cols="12" class="my-2">
          <Complete v-if="hasComplete" :jiman="jiman" @onRestart="onRestart" />
          <Confirm
            v-else-if="isConfirm"
            :jiman="jiman"
            @onSubmit="onSend"
            @onBack="onBack"
          />
          <Form
            v-else
            v-model="jiman"
            @onSubmit="onConfirm"
            @onReset="onReset"
          />
        </v-col>
      </v-row>
    </v-col>
  </v-row>
</template>
<script>
import Form from '~/components/contents/edit/Form.vue'
import Confirm from '~/components/contents/edit/Confirm.vue'
import Complete from '~/components/contents/edit/Complete.vue'

export default {
  components: {
    Form,
    Confirm,
    Complete
  },
  async fetch({ store, params }) {
    store.commit('jiman/CLEAR_JIMAN')
    await store.dispatch('jiman/fetchJiman', params.id)
  },
  data() {
    return {
      ENUM: { FORM: 1, CONFIRM: 2, COMPLETE: 3 },
      mode: 1
    }
  },
  computed: {
    jiman: {
      get() {
        return this.$store.state.jiman.jiman
      },
      set(v) {
        this.$store.commit('jiman/SET_JIMAN', v)
      }
    },
    isConfirm() {
      return this.mode === this.ENUM.CONFIRM || this.mode === this.ENUM.COMPLETE
    },
    hasComplete() {
      return this.mode === this.ENUM.COMPLETE
    }
  },
  methods: {
    async onReset() {
      await this.$store.dispatch('jiman/fetchJiman', this.$route.params.id)
    },
    onConfirm() {
      this.mode = this.ENUM.CONFIRM
    },
    async onSend() {
      await this.$store.dispatch('jiman/updateJiman', this.$route.params.id)
      this.mode = this.ENUM.COMPLETE
    },
    onBack() {
      this.mode = this.ENUM.FORM
    },
    async onRestart() {
      await this.$store.dispatch('jiman/fetchJiman', this.$route.params.id)
      this.mode = this.ENUM.FORM
    }
  }
}
</script>
<style></style>
