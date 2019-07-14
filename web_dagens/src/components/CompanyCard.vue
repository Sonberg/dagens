<template>
  <router-link tag="div" v-if="company" :to="`/companies/${company.id}`" :title="company.name">
    <!-- <b-img fluid :src="company.image || 'https://source.unsplash.com/random/800x600'" /> -->
    <div class="p-3">
      <h5 class="mb-2" v-html="company.name" />
      {{company.text}}
    </div>
  </router-link>
</template>

<script>
export default {
  props: {
    company: {}
  }
};
</script>