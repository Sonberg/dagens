<template>
<div>
    <b-navbar toggleable="lg" type="dark" variant="info">
        <b-navbar-brand to="/">Dagens</b-navbar-brand>

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

        <b-collapse id="nav-collapse" is-nav>

            <b-navbar-nav class="ml-auto">
                <b-nav-item-dropdown text="Companies" right v-if="allCompanies">
                    <b-dropdown-item :to="`/companies/${company.id}`" v-for="company of allCompanies" :key="company.id">
                        {{company.name}}
                    </b-dropdown-item>
                </b-nav-item-dropdown>

                <b-nav-item-dropdown right>
                    <!-- Using 'button-content' slot -->
                    <template slot="button-content"><em>User</em></template>
                    <b-dropdown-item href="#">Profile</b-dropdown-item>
                    <b-dropdown-item href="#">Sign Out</b-dropdown-item>
                </b-nav-item-dropdown>
            </b-navbar-nav>
        </b-collapse>
    </b-navbar>
</div>
</template>

<script>
import allCompanies from "@/graphql/AllCompanies.gql";

export default {
  apollo: {
    allCompanies
  }
};
</script>
