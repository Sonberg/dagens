<template>
  <nav>
    <b-container class="d-flex justify-content-between align-items-center py-4">
      <router-link tag="strong" to="/" v-html="'Dagens'" />
      {{profile && profile.name}}
    </b-container>
  </nav>
</template>

<script>
import allCompanies from "@/graphql/AllCompanies.gql";

export default {
  apollo: {
    allCompanies
  },
  props: ["profile"]
};
</script>


<style scoped>
nav {
  background-color: #3a5369 !important;
  color: white;
}
</style>
