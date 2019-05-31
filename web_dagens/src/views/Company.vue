<template>
    <b-form v-if="Company" class="mt-5" @submit="onSubmit">
        <h1 v-html="Company.name" />
        <b-form-group label="Namn">
            <input v-model="Company.name"/>
        </b-form-group>
        <b-form-group label="Bild">
            <input v-model="Company.image"/>
        </b-form-group>
        <b-button type="submit" variant="primary">Spara</b-button>
    </b-form>
    <b-row v-else class="mt-5">
        <b-col>
            <h1 v-html="'Not found'"/>
        </b-col>
    </b-row>
</template>

<script>
import company from "@/graphql/Company.gql";

export default {
  name: "company",
  methods: {
    onSubmit(evt) {
      evt.preventDefault();
      alert(this.Company.name);
    }
  },
  apollo: {
    Company: {
      query: company,
      variables() {
        return {
          id: this.$route.params.company_id
        };
      }
    }
  }
};
</script>
