<script setup>
defineProps({
  error: Object
})
</script>

<template>
  <ul class="my-6 text-red-800" v-if="error.errors">
    <li v-for="(errors, attributeName) in error.errors">
      <strong>{{ attributeName }}</strong>: {{ errors.join(",") }}
    </li>
  </ul>
</template>
