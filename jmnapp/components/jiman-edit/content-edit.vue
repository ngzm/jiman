<template>
  <v-row>
    <v-col cols="12" class="my-2">
      <Confirm
        v-if="isConfirm"
        :jiman="jiman"
        @submit="$emit('submit')"
        @back="onBack"
      />
      <Form
        v-else
        v-model="jiman"
        @confirm="onConfirm"
        @cancel="$emit('cancel')"
      />
    </v-col>
  </v-row>
</template>
<script>
import { Vue, Component } from 'nuxt-property-decorator'

import Form from '~/components/jiman-edit/content-form.vue'
import Confirm from '~/components/jiman-edit/content-confirm.vue'

@Component({
  components: { Form, Confirm }
})
export default class ContentEdit extends Vue {
  ENUM = { FORM: 1, CONFIRM: 2 }
  mode = 1

  get jiman() {
    return this.$store.state.jiman.jiman
  }

  set jiman(v) {
    this.$store.commit('jiman/SET_JIMAN', v)
  }

  get isConfirm() {
    return this.mode === this.ENUM.CONFIRM
  }

  onConfirm() {
    this.mode = this.ENUM.CONFIRM
  }

  onBack() {
    this.mode = this.ENUM.FORM
  }
}
</script>
<style></style>
