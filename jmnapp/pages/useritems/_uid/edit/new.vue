<template>
  <v-row class="mx-sm-6 mx-2">
    <v-col cols="12">
      <h4>新規登録</h4>
      <Edit @submit="onCreate" @cancel="onCancel" />
    </v-col>
    <CompleteDialog v-model="dialog" @ok="onOk">
      <h4>{{ $store.state.jiman.jiman.title }} を作成しました</h4>
    </CompleteDialog>
  </v-row>
</template>
<script>
import { Vue, Component } from 'nuxt-property-decorator'

import Edit from '~/components/jiman-edit/content-edit.vue'
import CompleteDialog from '~/components/jiman-edit/complete-dialog.vue'

@Component({
  components: { Edit, CompleteDialog },
  fetch({ store }) {
    store.commit('jiman/CLEAR_JIMAN')
  },
  validate({ params }) {
    return /^\d+$/.test(params.uid)
  }
})
export default class NewEditItemsJiman extends Vue {
  dispDialog = false

  get dialog() {
    return this.dispDialog
  }

  set dialog(v) {
    this.dispDialog = v
  }

  async onCreate() {
    await this.$store.dispatch('jiman/createJiman')
    this.dispDialog = true
  }

  onCancel() {
    this.$router.push(`/users/${this.$route.params.uid}`)
  }

  onOk() {
    this.dispDialog = false
    this.$router.push(`/users/${this.$route.params.uid}`)
  }
}
</script>
<style></style>
