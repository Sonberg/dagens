<template>
  <button @click="login">Logga in</button>
</template>

<script>

import auth0Client from './../auth/index';

export default {
methods: {
  login() {
     auth0Client.signIn();
  }
}
}
</script>

<style>

</style>
