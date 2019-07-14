<template>
  <div v-if="value">
    <form-input-group
      label="Latitude"
      name="latitude"
      error="Får inte vara tomt"
      :disabled="disabled"
      v-model="value.latitude"
    />

    <form-input-group
      label="Longitude"
      name="longitude"
      error="Får inte vara tomt"
      :disabled="disabled"
      v-model="value.longitude"
    />
    <GmapMap
      ref="mapRef"
      class="rounded"
      :center="center"
      :zoom="13"
      @click="didClick"
      style="width: 100%; height: 500px"
    >
      <GmapMarker :position="marker" :draggable="true" @dragend="didClick" v-if="marker" />
    </GmapMap>
  </div>
</template>

<script>
import FormInputGroup from "@/components/Form.Input.Group.vue";

export default {
  props: ["value", "disabled"],
  components: {
    FormInputGroup
  },
  data() {
    return {
      center: {
        lat: this.value.latitude.$model || 59.3,
        lng: this.value.longitude.$model || 18.0
      }
    };
  },
  computed: {
    listeners() {
      const { input, ...listeners } = this.$listeners;
      return listeners;
    },
    marker() {
      if (!this.value.latitude.$model || !this.value.longitude.$model) {
        return null;
      }

      return {
        lat: this.value.latitude.$model,
        lng: this.value.longitude.$model
      };
    }
  },
  methods: {
    didClick({ latLng }) {
      this.value.latitude.$model = latLng.lat();
      this.value.longitude.$model = latLng.lng();
    }
  }
};
</script>

<style>
.vue-map {
  border-radius: 0.25em;
}
</style>
