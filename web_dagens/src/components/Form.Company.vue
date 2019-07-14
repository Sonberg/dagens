<template>
  <div v-if="value">
    <form-input-group
      v-model="value.name"
      label="Namn"
      name="name"
      :disabled="disabled"
      error="Ett fel"
    />

    <form-input-group
      v-model="value.text"
      label="Säljande text (kort)"
      name="text"
      :disabled="disabled"
      error="Ett annat fel"
    />

  <slot/>

  </div>
</template>

<script>

import FormInputGroup from '@/components/Form.Input.Group.vue'

export default {
  props: ['value', 'disabled', 'file'],
  components: {
    FormInputGroup
  },
  computed: {
  listeners() {
    const { input, ...listeners } = this.$listeners;
    return listeners;
  }
}
}
</script>

