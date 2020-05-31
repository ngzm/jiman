<template>
  <v-row class="mx-sm-6 mx-2">
    <v-col cols="12">
      <h4>作品情報変更</h4>
      <JimanEdit :id="$route.params.id" :orginal="jiman" />
    </v-col>
  </v-row>
</template>
<script>
import JimanEdit from '~/components/contents/edit/Edit'

export default {
  scrollToTop: true,
  components: { JimanEdit },
  async asyncData(context) {
    let jdata = await context.$axios
      .$get(`${context.env.ENDPOINT_URL}/api/jimen/${context.params.id}`)
      .catch((err) => {
        console.log(`error !! ${err}`)
      })
    if (!jdata) jdata = {}
    return { jiman: jdata }
  }
}
</script>
<style></style>
