<template>
  <div class="mb-5">
    <navigation :profile="profile" />
    <router-view />
  </div>
</template>

<script>
import Navigation from "@/components/Navigation";
import auth0Client from "./auth/index";

export default {
  components: {
    Navigation
  },
  data: () => ({
    profile: null
  }),
  mounted() {
    this.profile = auth0Client.getProfile();
  }
};
</script>
