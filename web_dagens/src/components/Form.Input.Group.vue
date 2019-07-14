<template>
  <b-form-group :label="label" :label-for="`${name}-input`">
      <component
        :id="`${name}-input`"
        :state="value.$dirty ? !value.$error : null"
        :aria-describedby="`${name}-input-feedback`"
        :disabled="disabled"
        v-model="value.$model"
        :is="(as || 'b-form-input')" 
        v-on="listeners"/>
      <b-form-invalid-feedback :id="`${name}-input-feedback`" v-html="error"/>
    </b-form-group>
</template>

<script>
export default {
  props: ['name', 'value', 'label', 'error', 'as', 'disabled'],
    computed: {
  listeners() {
    const { input, ...listeners } = this.$listeners;
    return listeners;
  }
}
}
</script>
