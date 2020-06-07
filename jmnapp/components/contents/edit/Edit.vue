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
      <Form v-else v-model="jiman" @onSubmit="onConfirm" @onClear="onClear" />
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
    },
    id: {
      required: true,
      type: String
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
  async created() {
    console.log(this.id)
    await this.loadJiman()
    console.log(this.jiman)
  },
  methods: {
    async loadJiman() {
      try {
        const jdata = await this.$axios.$get(
          `${process.env.ENDPOINT_URL}/api/jimen/${this.id}`
        )
        // ----------------------------------------------------
        // 最初からデータがないと、computed で反応しないので注意
        // ----------------------------------------------------
        const imagedata = { name: '', type: ``, base64data: null }
        this.jiman = Object.assign(jdata, { imagedata })
      } catch (err) {
        console.log(`error !! ${err}`)
      }
    },
    async onClear() {
      await this.loadJiman()
    },
    onConfirm() {
      console.log(this.jiman)
      this.mode = this.ENUM.CONFIRM
    },
    async onSend() {
      let sendData = {
        title: this.jiman.title,
        description: this.jiman.description,
        url: this.jiman.url,
        point1: this.jiman.point1,
        point2: this.jiman.point2,
        point3: this.jiman.point3,
        point4: this.jiman.point4,
        categories: this.jiman.categories
      }
      if (this.jiman.imagedata && this.jiman.imagedata.base64data) {
        const imagedata = {
          name: this.jiman.imagedata.name,
          type: this.jiman.imagedata.type,
          base64data: this.jiman.imagedata.base64data.split(',')[1]
        }
        sendData = { ...sendData, imagedata }
      }
      console.log(sendData)
      const ret = await this.$axios
        .$put(
          `${process.env.ENDPOINT_URL}/api/jimen/${this.jiman.id}`,
          sendData
        )
        .catch((err) => {
          console.log(`error !! ${err}`)
        })
      console.log(ret)
      this.mode = this.ENUM.COMPLETE
    },
    onBack() {
      this.mode = this.ENUM.FORM
    },
    async onRestart() {
      await this.loadJiman()
      this.mode = this.ENUM.FORM
    }
  }
}
</script>
<style></style>
