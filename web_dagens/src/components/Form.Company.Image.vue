<template>
      <b-form-group label="Bild" label-for="input-file">
      <b-form-file 
        id="input-file"
        :value="value" 
        :disabled="disabled"
        accept="image/jpeg, image/png, image/gif"
        browse-text="Bläddra"
        @change="onChange"
        placeholder="Ingen bild vald"
        drop-placeholder="Släpp bild här"/>
    </b-form-group>
</template>

<script>


export default {
  props: ['value', 'disabled'],
  methods: {
    onChange({ target }) {
      this.$emit('input', target.files && target.validity.valid ? target.files[0] : null);
    }
  }
}
</script>