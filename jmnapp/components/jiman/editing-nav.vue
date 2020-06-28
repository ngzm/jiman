<template>
  <v-row justify="end">
    <v-col cols="auto">
      <v-btn class="info font-weight-bold" :to="editJiman">
        編集
      </v-btn>
      <v-btn class="error font-weight-bold">
        削除
      </v-btn>
    </v-col>
  </v-row>
</template>
<script>
import { Vue, Component, Prop } from 'nuxt-property-decorator'

@Component({})
export default class EditingNavJiman extends Vue {
  @Prop({ type: String, required: true }) uid
  @Prop({ type: String, required: true }) id

  get editJiman() {
    return `/useritems/${this.uid}/edit/${this.id}`
  }
}
</script>
