<template>
  <div class="border-bottom mb-3">
    <b-container>
      <b-row class="justify-content-between align-items-center my-3">
        <b-col class="col-auto">
          <h3 v-html="title" class="mb-0" />
        </b-col>
        <b-col class="col-auto">
          <slot />
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
export default {
  props: ["title"]
};
</script>