<template>
  <v-row class="mx-sm-6 mx-2">
    <v-col cols="12">
      <h4>新規登録</h4>
      <JimanEdit :orginal="jiman" />
    </v-col>
  </v-row>
</template>
<script>
import JimanEdit from '~/components/contents/edit/Edit'

export default {
  components: { JimanEdit },
  data() {
    return {
      jiman: {}
    }
  }
}
</script>
<style></style>
