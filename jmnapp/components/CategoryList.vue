<template>
  <v-list dense>
    <v-list-item
      v-for="(category, i) in categories"
      :key="i"
      :to="categoryto(category.id)"
      router
      exact
    >
      <v-list-item-action>
        <v-icon small>{{ categoryicon(i) }}</v-icon>
      </v-list-item-action>
      <v-list-item-content>
        <v-list-item-title v-text="category.name" />
      </v-list-item-content>
    </v-list-item>
  </v-list>
</template>

<script>
import { mapState, mapActions } from 'vuex'

export default {
  computed: {
    categoryto: () => (id) => {
      return `/categories/${id}`
    },
    categoryicon: () => (id) => {
      if (id % 2) {
        return 'mdi-apps'
      } else {
        return 'mdi-chart-bubble'
      }
    },
    ...mapState('category', ['categories'])
  },
  async created() {
    if (process.client) {
      await this.fetchCategories()
    }
  },
  methods: {
    ...mapActions('category', ['fetchCategories'])
  }
}
</script>
