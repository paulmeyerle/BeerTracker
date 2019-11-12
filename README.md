# BeerTracker

Graphql-Faker schema:
```
type Brewery {
  name: String @fake(type:companyName)
  address: String @fake(type:streetAddress, options: { useFullAddress: true })
  county:String @fake(type:county)
  state:String @fake(type:state)
  beers: [Beer!] @listLength(min: 5, max: 10)
}

type Beer {
  name: String @fake(type: productName, locale:en_CA)
  abv: Float @fake(type:number, options:{ minNumber:3, maxNumber:20, precisionNumber:0.1})
  ibu: Float @fake(type:number, options:{minNumber:5, maxNumber:130})
  type: String @examples(values: ["IPA", "Stout", "Porter", "Wheat", "Pilsner", "Lager"])
  brewery: Brewery
}

type Query {
  beer(id: ID): Beer
  brewery(id: ID): Brewery
  allBreweries: [Brewery!]
  searchBreweries(name: String): [Brewery!]
  searchBeers(name:String): [Beer!]
}
```
