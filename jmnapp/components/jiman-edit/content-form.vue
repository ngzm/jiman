<template>
  <v-form ref="form" v-model="valid" lazy-validation>
    <v-row no-gutters>
      <v-col cols="12" class="px-md-8 px-sm-6 xs-2">
        <h4 class="blue--text">掲載する作品情報を入力してください</h4>
      </v-col>
    </v-row>
    <v-row no-gutters justify="end">
      <v-col cols="auto" class="px-md-8 px-sm-6 px-2">
        <v-btn
          dark
          class="indigo darken-4 font-weight-bold"
          @click="$emit('cancel')"
        >
          キャンセル
        </v-btn>
        <v-btn
          :disabled="invalid"
          class="info font-weight-bold"
          @click="onConfirm"
        >
          入力完了
        </v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" md="6" class="px-md-8 px-sm-6 px-2">
        <v-file-input
          :rules="imageRules"
          accept="image/png, image/jpeg, image/gif"
          prepend-icon="mdi-file-image-outline"
          label="カバー画像選択"
          filled
          show-size
          class="mt-2"
          @change="getFileContent"
          @click:clear="clearFile"
        />
        <v-img v-if="!!imagesrc" max-height="300" :src="imagesrc" class="mb-6">
          <v-row align="end" class="lightbox white--text px-10 fill-height">
            <v-col>
              <div class="filetitle subheading pa-2">選択された画像</div>
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
          class="mt-2"
        />
        <v-text-field
          v-model="url"
          :counter="urlSize"
          :rules="urlRules"
          label="作品ページURL"
          filled
          required
          class="mt-2"
        />
        <v-textarea
          v-model="description"
          :counter="descriptionSize"
          :rules="descriptionRules"
          rows="6"
          label="作品概要"
          filled
          required
          class="mt-2"
        />
      </v-col>
      <v-col cols="12" md="6" class="px-md-8 px-sm-6 px-2">
        <v-select
          v-model="category1"
          item-text="name"
          item-value="id"
          :items="select1Items"
          dense
          filled
          label="カテゴリその1"
          class="mt-2"
        />
        <v-select
          v-model="category2"
          item-text="name"
          item-value="id"
          :items="selectItems"
          dense
          filled
          label="カテゴリその2"
        />
        <v-select
          v-model="category3"
          item-text="name"
          item-value="id"
          :items="selectItems"
          dense
          filled
          label="カテゴリその3"
        />
        <v-textarea
          v-model="point1"
          :counter="pointSize"
          :rules="point1Rules"
          rows="3"
          label="アピールポイントその1"
          filled
          required
          class="mt-2"
        />
        <v-textarea
          v-model="point2"
          :counter="pointSize"
          :rules="pointRules"
          rows="3"
          label="アピールポイントその2"
          filled
        />
        <v-textarea
          v-model="point3"
          :counter="pointSize"
          :rules="pointRules"
          rows="3"
          label="アピールポイントその3"
          filled
        />
        <v-textarea
          v-model="point4"
          :counter="pointSize"
          :rules="pointRules"
          rows="3"
          label="アピールポイントその4"
          filled
        />
      </v-col>
    </v-row>
  </v-form>
</template>
<script>
import { Vue, Component, Prop } from 'nuxt-property-decorator'

@Component
export default class ContentForm extends Vue {
  @Prop({ type: Object, required: true }) value

  titleSize = 40
  titleRules = [
    (v) => !!v || '必ず入力してください',
    (v) =>
      !v ||
      v.length <= this.titleSize ||
      `${this.titleSize}文字以内で入力してください`
  ]

  descriptionSize = 250
  descriptionRules = [
    (v) => !!v || '必ず入力してください',
    (v) =>
      !v ||
      v.length <= this.descriptionSize ||
      `${this.descriptionSize}文字以内で入力してください`
  ]

  urlSize = 80
  urlRules = [
    (v) => !!v || '必ず入力してください',
    (v) =>
      !v ||
      v.length <= this.titleSize ||
      `${this.titleSize}文字以内で入力してください`
  ]

  file = null
  imageSize = 4000000
  imageRules = [
    (v) =>
      !v ||
      v.size <= this.imageSize ||
      `ファイルサイズは 4MB 以内でお願いします`
  ]

  pointSize = 60
  pointRules = [
    (v) =>
      !v ||
      v.length <= this.pointSize ||
      `${this.pointSize}文字以内で入力してください`
  ]

  point1Rules = [
    (v) => !!v || '必ず入力してください',
    (v) =>
      !v ||
      v.length <= this.pointSize ||
      `${this.pointSize}文字以内で入力してください`
  ]

  valid = false

  get title() {
    return this.value ? this.value.title : ''
  }

  set title(data) {
    this.$emit('input', { title: data })
  }

  get description() {
    return this.value ? this.value.description : ''
  }

  set description(data) {
    this.$emit('input', { description: data })
  }

  get url() {
    return this.value ? this.value.url : ''
  }

  set url(data) {
    this.$emit('input', { url: data })
  }

  get imagesrc() {
    return this.imagedata ? this.imagedata : this.image
  }

  get image() {
    const image = this.value ? this.value.image : ''
    if (image && image.url) {
      return `${process.env.ENDPOINT_URL}${image.url}`
    }
    return null
  }

  get imagedata() {
    const imagedata = this.value ? this.value.imagedata : null
    if (imagedata && imagedata.base64data) {
      return imagedata.base64data
    }
    return null
  }

  set imagedata(data) {
    let imagedata = { name: '', type: '', base64data: null }
    if (this.file && data) {
      imagedata = {
        name: this.file.name,
        type: this.file.type,
        base64data: data
      }
    }
    this.$emit('input', { imagedata })
  }

  get category1() {
    const categories = this.value ? this.value.categories : null
    return categories ? (categories[0] ? categories[0].id : null) : null
  }

  set category1(data) {
    const ctgs = (this.value ? this.value.categories : []).concat()
    ctgs.splice(0, 1, {
      id: data,
      name: this.getCategoryName(data)
    })
    this.$emit('input', { categories: ctgs })
  }

  get category2() {
    const categories = this.value ? this.value.categories : null
    return categories ? (categories[1] ? categories[1].id : null) : null
  }

  set category2(data) {
    const ctgs = (this.value ? this.value.categories : []).concat()
    const ct =
      data === null ? null : { id: data, name: this.getCategoryName(data) }
    ctgs.splice(1, 1, ct)
    this.$emit('input', { categories: ctgs })
  }

  get category3() {
    const categories = this.value ? this.value.categories : null
    return categories ? (categories[2] ? categories[2].id : null) : null
  }

  set category3(data) {
    const ctgs = (this.value ? this.value.categories : []).concat()
    const ct =
      data === null ? null : { id: data, name: this.getCategoryName(data) }
    ctgs.splice(2, 1, ct)
    this.$emit('input', { categories: ctgs })
  }

  get point1() {
    return this.value ? this.value.point1 : ''
  }

  set point1(data) {
    this.$emit('input', { point1: data })
  }

  get point2() {
    return this.value ? this.value.point2 : ''
  }

  set point2(data) {
    this.$emit('input', { point2: data })
  }

  get point3() {
    return this.value ? this.value.point3 : ''
  }

  set point3(data) {
    this.$emit('input', { point3: data })
  }

  get point4() {
    return this.value ? this.value.point4 : ''
  }

  set point4(data) {
    this.$emit('input', { point4: data })
  }

  get invalid() {
    return !(
      this.valid &&
      this.title &&
      this.url &&
      this.description &&
      this.category1 &&
      this.point1 &&
      this.imagesrc
    )
  }

  get categories() {
    return this.$store.state.categories
  }

  get select1Items() {
    return this.categories.map((c) => ({ id: c.id, name: c.name }))
  }

  get selectItems() {
    const selections = [...this.select1Items]
    selections.unshift({ id: null, name: '選択してください' })
    return selections
  }

  get getCategoryName() {
    const self = this
    return (id) => {
      const category = self.$store.getters.getCategoryById(id)
      return category ? category.name : 'undefined'
    }
  }

  async getFileContent(file) {
    this.file = file
    if (file) {
      try {
        this.imagedata = await this.readFileAsync(file)
      } catch (e) {
        console.log(e)
      }
    } else {
      this.clearFile()
    }
  }

  readFileAsync(file) {
    return new Promise((resolve, reject) => {
      const reader = new FileReader()
      reader.onload = () => {
        resolve(reader.result)
      }
      reader.onerror = reject
      reader.readAsDataURL(file)
    })
  }

  onConfirm() {
    if (this.$refs.form.validate()) {
      this.$emit('confirm')
    }
  }

  clearFile() {
    this.file = null
    this.imagedata = null
  }
}
</script>
<style>
.filetitle {
  text-align: center;
  background-color: rgba(0, 64, 32, 0.75);
}
</style>
