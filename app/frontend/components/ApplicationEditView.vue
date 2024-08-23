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
  <h2 class="text-3xl my-6">Edition of {{ app.name }}</h2>
  <form @submit.prevent="onSubmit">
    <div class="my-2">
      <label for="name" class="inline-block w-32">Name</label>
      <input type="text" id="name" v-model="app.name" />
    </div>
    <div class="my-2">
      <label for="description" class="inline-block w-32 align-top">Description</label>
      <textarea id="description" v-model="app.description"></textarea>
    </div>
    <button type="submit"  class="px-4 py-2 mx-2 border-solid border-2 rounded-md shadow-md border-sky-600 bg-sky-100 hover:border-sky-800 hover:bg-sky-200 active:bg-sky-50 active:border-sky-400 active:shadow-none active:shadow-inner">Save</button>
    <router-link :to="{ name: 'Application', params: { id: app.id } }" class="text-sky-600 hover:text-sky-900 hover:underline">Cancel</router-link>
  </form>
  <ErrorMessage :error="error"></ErrorMessage>
</template>
