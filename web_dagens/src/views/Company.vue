<template>
  <div v-if="Company">
    <view-header :title="Company.name">
      <router-link :to="`/companies/${Company.id}/edit`">
        <v-icon name="fas fa-edit" />
      </router-link>
    </view-header>
    <b-container>
      <b-row class="d-flex align-items-center">
        <b-col>
          <p v-html="Company.text" />
        </b-col>
        <b-col sm="auto" v-if="Company.image">
          <img :src="Company.image" :alt="Company.name" style="height: 100px; width: 100px;" />
        </b-col>
      </b-row>
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
