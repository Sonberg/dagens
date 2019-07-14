<template>
  <div />
</template>

<script>
import auth0Client from "./../auth/index";

export default {
  async mounted() {
    await auth0Client.handleAuthentication();
    this.$router.push(localStorage.getItem("returnUrl") || "/");
  }
};
</script>
