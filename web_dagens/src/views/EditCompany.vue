<template>
  <div v-if="Company">
    <view-header :title="`Redigera ${Company.name}`" />
    <b-container>
      <b-form @submit.stop.prevent="onSubmit">
        <form-company v-model="$v.Company" :disabled="loading" class="mb-3">
          <form-company-image v-model="file" />
        </form-company>
        <form-geo-location v-model="$v.Company.geoLocation" :disabled="loading" />
        <b-row class="justify-content-end">
          <b-col sm="auto">
            <b-button
              type="submit"
              class="mt-3"
              :disabled="$v.$invalid || loading"
              variant="primary"
            >Spara</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-container>
  </div>
</template>

<script>
import ViewHeader from "@/components/View.Header.vue";
import FormCompany from "@/components/Form.Company.vue";
import FormCompanyImage from "@/components/Form.Company.Image.vue";
import FormGeoLocation from "@/components/Form.GeoLocation.vue";
import CompanyValidator, { data } from "@/validators/company";

import company from "@/graphql/Company.gql";
import CreateGeoLocation from "@/graphql/CreateGeoLocation.gql";
import UpdateCompany from "@/graphql/UpdateCompany.gql";
import UpdateGeoLocation from "@/graphql/UpdateGeoLocation.gql";
import UPLOAD_FILE from "@/graphql/UploadFile.gql";

export default {
  components: {
    ViewHeader,
    FormCompany,
    FormGeoLocation,
    FormCompanyImage
  },
  validations: CompanyValidator,
  methods: {
    async onSubmit() {
      if (this.$v.$anyError) {
        return;
      }

      this.loading = true;
      const { geoLocation, ...company } = this.Company;
      const image = (await this.uploadFile(this.file)) || company.image;

      await this.$apollo.mutate({
        mutation: UpdateCompany,
        variables: {
          ...company,
          imageId: image && image.id
        }
      });

      if (geoLocation) {
        await this.$apollo.mutate({
          mutation: UpdateGeoLocation,
          variables: {
            ...geoLocation,
            latitude: parseFloat(geoLocation.latitude),
            latitude: parseFloat(geoLocation.latitude),
            companyId: company.id
          }
        });
      }

      this.loading = false;
      this.$router.push("/");
    },
    async uploadFile(file) {
      try {
        if (!file) return null;

        const formData = new FormData();
        formData.append("data", this.file);

        const response = await fetch(
          "https://api.graph.cool/file/v1/cj65a1d7g03k60187mbo74qel",
          {
            method: "POST",
            mode: "no-cors",
            headers: {
              "Content-Type": "multipart/form-data"
            },
            body: formData
          }
        );

        return await response.json();
      } catch (error) {
        console.log(error);

        return null;
      }
    },
    async createGeoLocation() {
      await this.$apollo.mutate({
        mutation: CreateGeoLocation,
        variables: {
          latitude: 0.0,
          longitude: 0.0,
          companyId: this.$route.params.company_id
        }
      });

      this.$router.push(`/companies/${this.$route.params.company_id}`);
    }
  },
  data: () => ({
    ...data(),
    loading: false,
    file: null
  }),
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
