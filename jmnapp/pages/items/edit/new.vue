<template>
  <v-row class="mx-6">
    <v-col cols="12" sm="10" md="8" lg="6">
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
