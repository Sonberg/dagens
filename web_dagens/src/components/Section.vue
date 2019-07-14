<template>
  <div>
    <b-row @click="toggle">
      <b-col>
        <h5 v-html="title" class="m-0"/>
      </b-col>
      <b-col sm="auto">
        <v-icon name="res chevron-down" />
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <hr>
      </b-col>
    </b-row>
    <b-row v-if="open">
      <b-col>
        <slot/>
      </b-col>
    </b-row>
  </div>
</template>

<script>
export default {
  props: ["title"],
  data: () => ({
    open: false
  }),
  methods: {
    toggle() {
      this.open = !this.open;
    }
  }
};
</script>