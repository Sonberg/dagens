<template>
  <i :class="name"></i>
</template>

<script>
export default {
  props: ["name"]
};
</script>

<style scoped>
i {
  color: black;
}
</style>
