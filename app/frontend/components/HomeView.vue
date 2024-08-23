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
  <h2>Applications</h2>
  <ul>
    <li v-for="app in apps" :key="app.id">
      <router-link :to="{ name: 'Application', params: { id: app.id } }">
        {{ app.name }}
      </router-link>
    </li>
  </ul>
  <h3>New application</h3>
  <form @submit.prevent="onSubmitNewApp">
    <div>
      <label for="name">Name</label>
      <input type="text" id="name" v-model="newApp.name" />
    </div>
    <div>
      <label for="description">Description</label>
      <textarea id="description" v-model="newApp.description"></textarea>
    </div>
    <button type="submit">Save</button>
  </form>
  <ErrorMessage :error="error"></ErrorMessage>
</template>
