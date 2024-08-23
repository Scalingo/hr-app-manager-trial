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
  <h2 class="text-3xl my-6">{{ app.name }}</h2>
  <p class="my-2">{{ app.description }}</p>
  <div class="my-2">
    <router-link class="inline-block m-2 text-sky-600 hover:text-sky-900 hover:underline" to="/">Back</router-link>
    <router-link class="inline-block m-2 text-sky-600 hover:text-sky-900 hover:underline" :to="{ name: 'ApplicationEdit', params: { id: app.id } }">Edit</router-link>
    <button class="m-2 px-4 py-2 border-solid border-2 rounded-md shadow-md border-red-600 bg-red-100 hover:border-red-800 hover:bg-red-200 active:bg-red-50 active:border-red-400 active:shadow-none active:shadow-inner" @click="onDestroy">Destroy</button>
  </div>
  <ErrorMessage :error="error"></ErrorMessage>
</template>
