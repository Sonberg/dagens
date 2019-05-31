String filterGeoLocations = """
query filterGeoLocations(\$fromLat: Float, \$toLat: Float, \$fromLong: Float, \$toLong: Float, \$tags: [ID!]) {
  allGeoLocations(filter: { latitude_gte: \$fromLat, latitude_lte: \$toLat, longitude_lte: \$toLong, longitude_gte: \$fromLong, company: { offers_some: { tags_some: { id_in: \$tags }}}  }) {
    id
    latitude
    longitude
    company {
      id,
      name,
      image,
      tags {
        id,
        value
      },
      offers {
        id,
        name,
        tags {
          id,
          value
        }
      }
    }
  }
}

"""
    .replaceAll('\n', ' ');

String allTags = """
query allTags{
  allTags(filter: { offers_some: {} }){
    id,
    value,
    offers {
      id
    }
  }
}
"""
    .replaceAll('\n', ' ');
