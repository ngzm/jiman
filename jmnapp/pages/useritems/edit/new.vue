<template>
  <v-row class="mx-sm-6 mx-2">
    <v-col cols="12">
      <h4>新規登録</h4>
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
import Form from '~/components/jiman-edit/Form.vue'
import Confirm from '~/components/jiman-edit/Confirm.vue'
import Complete from '~/components/jiman-edit/Complete.vue'

export default {
  components: {
    Form,
    Confirm,
    Complete
  },
  fetch({ store, params }) {
    store.commit('jiman/CLEAR_JIMAN')
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
        console.log(v)
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
    onReset() {
      this.$store.commit('jiman/CLEAR_JIMAN')
    },
    onConfirm() {
      this.mode = this.ENUM.CONFIRM
    },
    async onSend() {
      await this.$store.dispatch('jiman/createJiman')
      this.mode = this.ENUM.COMPLETE
    },
    onBack() {
      this.mode = this.ENUM.FORM
    },
    onRestart() {
      this.$store.commit('jiman/CLEAR_JIMAN')
      this.mode = this.ENUM.FORM
    }
  }
}
</script>
<style></style>
