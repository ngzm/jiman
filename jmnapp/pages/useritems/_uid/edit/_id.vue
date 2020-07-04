<template>
  <v-row class="mx-sm-6 mx-2">
    <v-col cols="12">
      <h4>作品情報変更</h4>
      <Edit @submit="onUpdate" @cancel="onCancel" />
    </v-col>
    <CompleteDialog v-model="dialog" @ok="onOk">
      <h4>{{ $store.state.jiman.jiman.title }} の変更を完了しました</h4>
    </CompleteDialog>
  </v-row>
</template>
<script>
import { Vue, Component } from 'nuxt-property-decorator'

import Edit from '~/components/jiman-edit/content-edit.vue'
import CompleteDialog from '~/components/jiman-edit/complete-dialog.vue'

@Component({
  components: { Edit, CompleteDialog },
  async fetch({ store, params }) {
    store.commit('jiman/CLEAR_JIMAN')
    await store.dispatch('jiman/fetchJiman', params.id)
  },
  validate({ params }) {
    return /^\d+$/.test(params.uid) && /^\d+$/.test(params.id)
  },
})
export default class IdEditItemsJiman extends Vue {
  dispDialog = false

  get dialog() {
    return this.dispDialog
  }

  set dialog(v) {
    this.dispDialog = v
  }

  async onUpdate() {
    await this.$store.dispatch('jiman/updateJiman', this.$route.params.id)
    this.dispDialog = true
  }

  onCancel() {
    this.$router.push(
      `/useritems/${this.$route.params.uid}/${this.$route.params.id}`
    )
  }

  onOk() {
    this.dispDialog = false
    this.$router.push(
      `/useritems/${this.$route.params.uid}/${this.$route.params.id}`
    )
  }
}
</script>
<style></style>
