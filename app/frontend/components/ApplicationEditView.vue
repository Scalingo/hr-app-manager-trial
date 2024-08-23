<script setup>
import router from '../entrypoints/router';
import ErrorMessage from './ErrorMessage.vue'

defineProps({
  id: String
})
</script>

<script>
export default {
  data() {
    return {
      app: {
        id: 0,
        name: '',
        description: '',
      },
      error: {},
    }
  },
  created() {
    this.fetchApp()
  },
  methods: {
    async fetchApp() {
      const response = await fetch(`/applications/${this.id}.json`)
      this.app = await response.json()
    },
    async onSubmit() {
      this.error = {}
      const response = await fetch(`/applications/${this.id}.json`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        },
        body: JSON.stringify(this.app),
      })

      if (response.ok) {
        router.push({ name: 'Application', params: { id: this.id } })
        return
      }

      this.error = await response.json()
    }
  },
}
</script>

<template>
  <form @submit.prevent="onSubmit">
    <div>
      <label for="name">Name</label>
      <input type="text" id="name" v-model="app.name" />
    </div>
    <div>
      <label for="description">Description</label>
      <textarea id="description" v-model="app.description"></textarea>
    </div>
    <button type="submit">Save</button>
    <p><router-link :to="{ name: 'Application', params: { id: app.id } }">Cancel</router-link></p>
  </form>
  <ErrorMessage :error="error"></ErrorMessage>
</template>
