<template>
  <v-form ref="form" v-model="valid" lazy-validation>
    <h4 class="blue--text">掲載したい作品情報を入力してください</h4>
    <v-file-input
      :rules="imgdataRules"
      accept="image/png, image/jpeg, image/gif"
      prepend-icon="mdi-file-image-outline"
      label="作品イメージ選択"
      filled
      show-size
      class="mt-8"
      @change="getFileContent"
      @click:clear="clearFileContent"
    />
    <v-img v-if="!!imgdata" max-height="340" :src="imgdata">
      <v-row
        v-if="!!file"
        align="end"
        class="lightbox white--text px-10 fill-height"
      >
        <v-col>
          <div class="filetitle subheading pa-2">{{ file.name }}</div>
        </v-col>
      </v-row>
    </v-img>
    <v-text-field
      v-model="title"
      :counter="titleSize"
      :rules="titleRules"
      label="作品タイトル"
      filled
      required
      class="mt-6"
    />
    <v-text-field
      v-model="url"
      :counter="urlSize"
      :rules="urlRules"
      label="作品ページURL"
      filled
      required
      class="mt-6"
    />
    <v-textarea
      v-model="description"
      :counter="descriptionSize"
      :rules="descriptionRules"
      rows="6"
      label="作品概要"
      filled
      required
      class="mt-4"
    />
    <v-textarea
      v-model="point1"
      :counter="pointSize"
      :rules="point1Rules"
      rows="2"
      label="アピールポイントその1"
      filled
      required
      class="mt-4"
    />
    <v-textarea
      v-model="point2"
      :counter="pointSize"
      :rules="pointRules"
      rows="2"
      label="アピールポイントその2"
      filled
      class="mt-4"
    />
    <v-textarea
      v-model="point3"
      :counter="pointSize"
      :rules="pointRules"
      rows="2"
      label="アピールポイントその3"
      filled
      class="mt-4"
    />
    <v-textarea
      v-model="point4"
      :counter="pointSize"
      :rules="pointRules"
      rows="2"
      label="アピールポイントその4"
      filled
      class="mt-4"
    />
    <div class="mt-3">
      <v-btn :disabled="invalid" class="info font-weight-bold" @click="submit">
        確認
      </v-btn>
      <v-btn class="indigo darken-4 font-weight-bold" @click="clear">
        クリア
      </v-btn>
    </div>
  </v-form>
</template>
<script>
export default {
  props: {
    jiman: {
      required: true,
      type: Object
    }
  },
  data() {
    return {
      valid: false,
      title: '',
      titleSize: 40,
      titleRules: [
        (v) => !!v || '必ず入力してください',
        (v) =>
          !v ||
          v.length <= this.titleSize ||
          `${this.titleSize}文字以内で入力してください`
      ],
      url: '',
      urlSize: 80,
      urlRules: [
        (v) => !!v || '必ず入力してください',
        (v) =>
          !v ||
          v.length <= this.titleSize ||
          `${this.titleSize}文字以内で入力してください`
      ],
      description: '',
      descriptionSize: 250,
      descriptionRules: [
        (v) => !!v || '必ず入力してください',
        (v) =>
          !v ||
          v.length <= this.descriptionSize ||
          `${this.descriptionSize}文字以内で入力してください`
      ],
      file: null,
      imgdata: null,
      imgdataSize: 4000000,
      imgdataRules: [
        (v) =>
          !v ||
          v.size <= this.imgdataSize ||
          `ファイルサイズは 4MB 以内でお願いします`
      ],
      point1: '',
      point2: '',
      point3: '',
      point4: '',
      pointSize: 60,
      point1Rules: [
        (v) => !!v || '必ず入力してください',
        (v) =>
          !v ||
          v.length <= this.pointSize ||
          `${this.pointSize}文字以内で入力してください`
      ],
      pointRules: [
        (v) =>
          !v ||
          v.length <= this.pointSize ||
          `${this.pointSize}文字以内で入力してください`
      ]
    }
  },
  computed: {
    invalid() {
      return !(
        this.valid &&
        this.title &&
        this.url &&
        this.description &&
        this.point1 &&
        this.imgdata
      )
    }
  },
  mounted() {
    this.title = this.jiman.title || ''
    this.url = this.jiman.url || ''
    this.description = this.jiman.description || ''
    this.file = this.jiman.file || ''
    this.imgdata = this.jiman.imgdata || ''
    this.point1 = this.jiman.point1 || ''
    this.point2 = this.jiman.point2 || ''
    this.point3 = this.jiman.point3 || ''
    this.point4 = this.jiman.point4 || ''
  },
  methods: {
    async getFileContent(file) {
      try {
        const imgdata = await this.readFileAsync(file)
        this.imgdata = imgdata
        this.file = file
      } catch (e) {
        console.log(e)
      }
    },
    readFileAsync(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader()
        reader.onload = () => {
          resolve(reader.result)
        }
        reader.onerror = reject
        reader.readAsDataURL(file)
      })
    },
    clearFileContent() {
      this.file = null
      this.imgdata = null
    },
    submit() {
      if (this.$refs.form.validate()) {
        this.$emit('onSubmit', {
          title: this.title,
          url: this.url,
          description: this.description,
          file: this.file,
          imgdata: this.imgdata,
          point1: this.point1,
          point2: this.point2,
          point3: this.point3,
          point4: this.point4
        })
      }
    },
    clear() {
      this.$refs.form.reset()
      this.file = null
      this.imgdata = null
    }
  }
}
</script>
<style>
.filetitle {
  text-align: center;
  background-color: rgba(0, 64, 32, 0.75);
}
</style>
