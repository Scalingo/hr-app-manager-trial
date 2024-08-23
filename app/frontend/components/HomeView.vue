<script setup>
import ErrorMessage from './ErrorMessage.vue'
</script>

<script>
export default {
  data() {
    return {
      apps: [],
      newApp: {
        name: '',
        description: '',
      },
      error: {},
    }
  },
  created() {
    this.fetchApps()
  },
  methods: {
    async fetchApps() {
      const response = await fetch('/applications.json')
      this.apps = await response.json()
    },
    async onSubmitNewApp() {
      this.error = {}
      const response = await fetch(`/applications.json`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        },
        body: JSON.stringify(this.newApp),
      })

      if (response.ok) {
        this.apps.push(await response.json())
        this.newApp = { name: '', description: '' }
        return
      }

      this.error = await response.json()
    },
  },
}
</script>

<template>
  <h2 class="text-3xl my-6">Applications</h2>
  <ul class="my-6">
    <li v-for="app in apps" :key="app.id">
      <router-link class="text-sky-600 hover:text-sky-900 hover:underline" :to="{ name: 'Application', params: { id: app.id } }">
        {{ app.name }}
      </router-link>
    </li>
  </ul>
  <h3 class="text-2xl my-6">New application</h3>
  <form @submit.prevent="onSubmitNewApp">
    <div class="my-2">
      <label for="name" class="inline-block w-32">Name</label>
      <input type="text" class="w-96" id="name" v-model="newApp.name" />
    </div>
    <div class="my-2">
      <label for="description" class="inline-block w-32 align-top">Description</label>
      <textarea id="description" class="w-96" v-model="newApp.description"></textarea>
    </div>
    <button type="submit" class="px-4 py-2 border-solid border-2 rounded-md shadow-md border-sky-600 bg-sky-100 hover:border-sky-800 hover:bg-sky-200 active:bg-sky-50 active:border-sky-400 active:shadow-none active:shadow-inner">Save</button>
  </form>
  <ErrorMessage :error="error"></ErrorMessage>
</template>
