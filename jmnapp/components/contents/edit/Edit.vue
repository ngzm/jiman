<template>
  <v-row>
    <v-col cols="12" class="my-2">
      <Complete v-if="hasComplete" :jiman="jiman" @onRestart="onRestart" />
      <Confirm
        v-else-if="isConfirm"
        :jiman="jiman"
        @onSubmit="onSend"
        @onBack="onBack"
      />
      <Form v-else :jiman="jiman" @onSubmit="onConfirm" />
    </v-col>
  </v-row>
</template>
<script>
import Form from './Form.vue'
import Confirm from './Confirm.vue'
import Complete from './Complete.vue'

export default {
  components: { Form, Confirm, Complete },
  props: {
    orginal: {
      required: true,
      type: Object
    }
  },
  data() {
    return {
      ENUM: { FORM: 1, CONFIRM: 2, COMPLETE: 3 },
      mode: 1,
      jiman: {}
    }
  },
  computed: {
    isConfirm() {
      return this.mode === this.ENUM.CONFIRM || this.mode === this.ENUM.COMPLETE
    },
    hasComplete() {
      return this.mode === this.ENUM.COMPLETE
    }
  },
  mounted() {
    this.jiman = { ...this.oiginal }
  },
  methods: {
    onConfirm(form) {
      console.log(form)
      this.jiman = { ...form }
      this.mode = this.ENUM.CONFIRM
    },
    async onSend() {
      const postdata = {
        file: this.jiman.file.name,
        type: this.jiman.file.type,
        imgdata: this.jiman.imgdata.split(',')[1],
        title: this.jiman.title,
        url: this.jiman.url,
        description: this.jiman.description,
        point1: this.jiman.point1,
        point2: this.jiman.point2,
        point3: this.jiman.point3,
        point4: this.jiman.point4
      }
      console.log(postdata)
      const ret = await this.$axios
        .$post(`${process.env.ENDPOINT_URL}/api/jimen`, postdata)
        .catch((err) => {
          console.log(`error !! ${err}`)
        })
      console.log(ret)
      this.mode = this.ENUM.COMPLETE
    },
    onBack() {
      this.mode = this.ENUM.FORM
    },
    onRestart() {
      this.jiman = {}
      this.jiman = { ...this.oiginal }
      this.mode = this.ENUM.FORM
    }
  }
}
</script>
<style></style>
