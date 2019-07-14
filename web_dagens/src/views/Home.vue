<template>
  <div>
    <view-header :title="`Restauranger (${allCompanies ? allCompanies.length : 0})`">
      <router-link to="companies/create">
        <v-icon name="fas fa-plus" />
      </router-link>
    </view-header>

    <b-container>
      <div class="grid">
        <company-card
          class="grid-item border"
          v-for="item of allCompanies"
          :key="item.id"
          :company="item"
        />
      </div>
    </b-container>
  </div>
</template>

<script>
import CompanyCard from "@/components/CompanyCard";
import ViewHeader from "@/components/View.Header";
import allCompanies from "@/graphql/AllCompanies.gql";

export default {
  name: "home",
  components: {
    CompanyCard,
    ViewHeader
  },
  apollo: {
    allCompanies
  }
};
</script>

<style scoped>
.grid {
  display: grid;
  grid-template-columns: 1fr;
  grid-gap: 1em;
}

.grid-item:hover {
  background: rgba(0, 0, 0, 0.02);
}
</style>
