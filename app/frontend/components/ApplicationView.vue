<script setup>
defineProps({
  id: String
})
</script>

<script>
export default {
  data() {
    return {
      app: {
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
    async onDestroy() {
      this.error = {}
      if (!confirm('Are you sure?')) {
        return
      }

      const response = await fetch(`/applications/${this.id}.json`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        },
      })

      if (response.ok) {
        this.$router.push('/')
        return
      }

      this.error = await response.json()
    },
  },
}
</script>

<template>
  <h2>{{ app.name }}</h2>
  <p>{{ app.description }}</p>
  <p><router-link :to="{ name: 'ApplicationEdit', params: { id: app.id } }">Edit</router-link></p>
  <p><button @click="onDestroy">Destroy</button></p>
  <ErrorMessage :error="error"></ErrorMessage>
  <p><router-link to="/">back</router-link></p>
</template>
