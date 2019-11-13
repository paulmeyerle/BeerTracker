# BeerTracker

Graphql-Faker schema:
```
type Brewery {
  imageURL: String @fake(type:imageUrl, options:{randomizeImageUrl: true})
  name: String @fake(type:companyName)
  address: String @fake(type:streetAddress, options: { useFullAddress: true })
  county:String @fake(type:county)
  state:String @fake(type:state)
  beers: [Beer!] @listLength(min: 5, max: 10)
}

type Beer {
  imageURL: String @fake(type:imageUrl, options:{randomizeImageUrl: true})
  name: String @fake(type: productName, locale:en_CA)
  abv: Float @fake(type:number, options:{ minNumber:3, maxNumber:20, precisionNumber:0.1})
  ibu: Float @fake(type:number, options:{minNumber:5, maxNumber:130})
  type: String @examples(values: ["IPA", "Stout", "Porter", "Wheat", "Pilsner", "Lager"])
  rating: Float @fake(type:number, options: { minNumber: 0, maxNumber: 5, precisionNumber:0.1})
  brewery: Brewery!
}

type Rating {
  rating: Float @fake(type:number, options: { minNumber: 0, maxNumber: 5, precisionNumber:0.1 })
  beer: Beer!
}

type Query {
  beer(id: Int): Beer
  brewery(id: Int): Brewery
  searchBeers(name:String): [Beer!] @listLength(min: 2, max:10)
  myRatings:[Rating!] @listLength(min: 4, max:20)
}

type Mutation {
  rateBeer(id: Int, rating: Float): Rating
}
```
