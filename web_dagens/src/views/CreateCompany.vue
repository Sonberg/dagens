<template>
  <div>
    <view-header title="Skapa ny" />
    <b-container>
      <b-form @submit.stop.prevent="onSubmit">
        <form-company v-model="$v.Company" :disabled="loading" />
        <h5 class="mt-3">Plats</h5>
        <form-geo-location v-model="$v.Company.geoLocation" :disabled="loading" />

        <b-row class="justify-content-between">
          <b-col sm="auto">
            <b-button to="/" class="mt-3" variant="outline-secondary" :disabled="loading">Avbryt</b-button>
          </b-col>
          <b-col sm="auto">
            <b-button
              type="submit"
              class="mt-3"
              variant="primary"
              :disabled="$v.$invalid || loading"
            >Skapa</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-container>
  </div>
</template>

<script>
import CreateCompany from "@/graphql/CreateCompany.gql";
import CreateGeoLocation from "@/graphql/CreateGeoLocation.gql";
import FormCompany from "@/components/Form.Company.vue";
import FormGeoLocation from "@/components/Form.GeoLocation.vue";
import ViewHeader from "@/components/View.Header.vue";
import CompanyValidator, { data } from "@/validators/company";

export default {
  components: {
    FormCompany,
    FormGeoLocation,
    ViewHeader
  },
  validations: CompanyValidator,
  methods: {
    async onSubmit() {
      if (this.$v.$anyError) {
        return;
      }
      this.loading = true;

      const result = await this.$apollo.mutate({
        mutation: CreateCompany,
        variables: this.Company
      });

      await this.$apollo.mutate({
        mutation: CreateGeoLocation,
        variables: {
          latitude: parseFloat(this.Company.geoLocation.latitude),
          longitude: parseFloat(this.Company.geoLocation.longitude),
          companyId: result.data.createCompany.id
        }
      });

      this.loading = false;
      this.$router.push(`/${result.data.createCompany.id}`);
    }
  },
  data: () => ({
    ...data(),
    loading: false
  })
};
</script>
