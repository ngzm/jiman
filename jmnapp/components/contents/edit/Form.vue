<template>
  <v-form ref="form" v-model="valid" lazy-validation>
    <v-row no-gutters>
      <v-col cols="12" class="px-md-8 px-sm-6 xs-2">
        <h4 class="blue--text">掲載したい作品情報を入力してください</h4>
      </v-col>
    </v-row>
    <v-row no-gutters justify="end">
      <v-col cols="auto" class="px-md-8 px-sm-6 px-2">
        <v-btn
          :disabled="invalid"
          class="info font-weight-bold"
          @click="submit"
        >
          確認
        </v-btn>
        <v-btn class="indigo darken-4 font-weight-bold" @click="clear">
          クリア
        </v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" md="6" class="px-md-8 px-sm-6 px-2">
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
        <v-select
          v-model="category1"
          item-text="name"
          item-value="id"
          :items="selectItems"
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
        <v-textarea
          v-model="point1"
          :counter="pointSize"
          :rules="point1Rules"
          rows="2"
          label="アピールポイントその1"
          filled
          required
          class="mt-2"
        />
        <v-textarea
          v-model="point2"
          :counter="pointSize"
          :rules="pointRules"
          rows="2"
          label="アピールポイントその2"
          filled
        />
        <v-textarea
          v-model="point3"
          :counter="pointSize"
          :rules="pointRules"
          rows="2"
          label="アピールポイントその3"
          filled
        />
        <v-textarea
          v-model="point4"
          :counter="pointSize"
          :rules="pointRules"
          rows="2"
          label="アピールポイントその4"
          filled
        />
      </v-col>
    </v-row>
  </v-form>
</template>
<script>
import { mapState } from 'vuex'

export default {
  props: {
    value: {
      required: true,
      type: Object
    }
  },
  data() {
    return {
      valid: false,
      titleSize: 40,
      titleRules: [
        (v) => !!v || '必ず入力してください',
        (v) =>
          !v ||
          v.length <= this.titleSize ||
          `${this.titleSize}文字以内で入力してください`
      ],
      descriptionSize: 250,
      descriptionRules: [
        (v) => !!v || '必ず入力してください',
        (v) =>
          !v ||
          v.length <= this.descriptionSize ||
          `${this.descriptionSize}文字以内で入力してください`
      ],
      urlSize: 80,
      urlRules: [
        (v) => !!v || '必ず入力してください',
        (v) =>
          !v ||
          v.length <= this.titleSize ||
          `${this.titleSize}文字以内で入力してください`
      ],
      file: null,
      imageSize: 4000000,
      imageRules: [
        (v) =>
          !v ||
          v.size <= this.imageSize ||
          `ファイルサイズは 4MB 以内でお願いします`
      ],
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
    title: {
      get() {
        return this.value ? this.value.title : ''
      },
      set(data) {
        const jiman = Object.assign(this.value, { title: data })
        this.$emit('input', jiman)
      }
    },
    description: {
      get() {
        return this.value ? this.value.description : ''
      },
      set(data) {
        const jiman = Object.assign(this.value, { description: data })
        this.$emit('input', jiman)
      }
    },
    url: {
      get() {
        return this.value ? this.value.url : ''
      },
      set(data) {
        const jiman = Object.assign(this.value, { url: data })
        this.$emit('input', jiman)
      }
    },
    imagesrc() {
      return this.imagedata ? this.imagedata : this.image
    },
    image() {
      const image = this.value ? this.value.image : ''
      if (image && image.url) {
        return `${process.env.ENDPOINT_URL}${image.url}`
      }
      return null
    },
    imagedata: {
      get() {
        const imagedata = this.value ? this.value.imagedata : null
        if (imagedata && imagedata.base64data) {
          return imagedata.base64data
        }
        return null
      },
      set(data) {
        let imagedata = null
        if (this.file && data) {
          imagedata = {
            name: this.file.name,
            type: this.file.type,
            base64data: data
          }
        }
        const jiman = Object.assign(this.value, { imagedata })
        this.$emit('input', jiman)
      }
    },
    category1: {
      get() {
        const categories = this.value ? this.value.categories : null
        return categories ? (categories[0] ? categories[0].id : null) : null
      },
      set(data) {
        const ctgs = this.value ? this.value.categories : []
        ctgs.splice(0, 1, {
          id: data,
          name: this.getCategoryName(data)
        })
        const jiman = Object.assign(this.value, { categories: ctgs })
        this.$emit('input', jiman)
      }
    },
    category2: {
      get() {
        const categories = this.value ? this.value.categories : null
        return categories ? (categories[1] ? categories[1].id : null) : null
      },
      set(data) {
        const ctgs = this.value ? this.value.categories : []
        ctgs.splice(1, 1, {
          id: data,
          name: this.getCategoryName(data)
        })
        const jiman = Object.assign(this.value, { categories: ctgs })
        this.$emit('input', jiman)
      }
    },
    category3: {
      get() {
        const categories = this.value ? this.value.categories : null
        return categories ? (categories[2] ? categories[2].id : null) : null
      },
      set(data) {
        const ctgs = this.value ? this.value.categories : []
        ctgs.splice(2, 1, {
          id: data,
          name: this.getCategoryName(data)
        })
        const jiman = Object.assign(this.value, { categories: ctgs })
        this.$emit('input', jiman)
      }
    },
    point1: {
      get() {
        return this.value ? this.value.point1 : ''
      },
      set(data) {
        const jiman = Object.assign(this.value, { point1: data })
        this.$emit('input', jiman)
      }
    },
    point2: {
      get() {
        return this.value ? this.value.point2 : ''
      },
      set(data) {
        const jiman = Object.assign(this.value, { point2: data })
        this.$emit('input', jiman)
      }
    },
    point3: {
      get() {
        return this.value ? this.value.point3 : ''
      },
      set(data) {
        const jiman = Object.assign(this.value, { point3: data })
        this.$emit('input', jiman)
      }
    },
    point4: {
      get() {
        return this.value ? this.value.point4 : ''
      },
      set(data) {
        const jiman = Object.assign(this.value, { point4: data })
        this.$emit('input', jiman)
      }
    },
    invalid() {
      return !(
        this.valid &&
        this.title &&
        this.url &&
        this.description &&
        this.category1 &&
        this.point1 &&
        this.imagesrc
      )
    },
    selectItems() {
      return this.categories.map((c) => ({ id: c.id, name: c.name }))
    },
    ...mapState(['categories'])
  },
  methods: {
    getCategoryName(id) {
      const category = this.$store.getters.getCategoryById(id)
      return category ? category.name : 'undefined'
    },
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
    submit() {
      if (this.$refs.form.validate()) {
        this.$emit('onSubmit')
      }
    },
    clear() {
      this.$refs.form.reset()
      this.file = null
      this.$emit('onClear')
    },
    clearFile() {
      this.file = null
      this.imagedata = null
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
