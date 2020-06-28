<template>
  <v-dialog v-model="dialog" persistent max-width="400">
    <v-card class="pa-4">
      <v-card-text class="mt-3">
        <slot></slot>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn class="primary font-weight-bold" @click="$emit('ok')">
          OK
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>
<script>
import { Vue, Component, Prop } from 'nuxt-property-decorator'

@Component
export default class CompleteDialog extends Vue {
  @Prop({ type: Boolean, required: true }) value

  get dialog() {
    return this.value
  }

  set dialog(v) {
    this.$emit('input', v)
  }
}
</script>
<style></style>
