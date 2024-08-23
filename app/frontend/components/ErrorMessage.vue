<script setup>
defineProps({
  error: Object
})
</script>

<template>
  <ul v-if="error.errors">
    <li v-for="(errors, attributeName) in error.errors">
      {{ attributeName }}: {{ errors.join(",") }}
    </li>
  </ul>
</template>
