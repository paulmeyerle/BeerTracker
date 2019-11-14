//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class MyRatingsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query MyRatings {
      myRatings {
        __typename
        rating
        beer {
          __typename
          rating
          imageURL
          name
          abv
          ibu
          type
          brewery {
            __typename
            imageURL
            name
            address
            state
            county
          }
        }
      }
    }
    """

  public let operationName = "MyRatings"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("myRatings", type: .list(.nonNull(.object(MyRating.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(myRatings: [MyRating]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "myRatings": myRatings.flatMap { (value: [MyRating]) -> [ResultMap] in value.map { (value: MyRating) -> ResultMap in value.resultMap } }])
    }

    public var myRatings: [MyRating]? {
      get {
        return (resultMap["myRatings"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [MyRating] in value.map { (value: ResultMap) -> MyRating in MyRating(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [MyRating]) -> [ResultMap] in value.map { (value: MyRating) -> ResultMap in value.resultMap } }, forKey: "myRatings")
      }
    }

    public struct MyRating: GraphQLSelectionSet {
      public static let possibleTypes = ["Rating"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("rating", type: .scalar(Double.self)),
        GraphQLField("beer", type: .nonNull(.object(Beer.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(rating: Double? = nil, beer: Beer) {
        self.init(unsafeResultMap: ["__typename": "Rating", "rating": rating, "beer": beer.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var rating: Double? {
        get {
          return resultMap["rating"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "rating")
        }
      }

      public var beer: Beer {
        get {
          return Beer(unsafeResultMap: resultMap["beer"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "beer")
        }
      }

      public struct Beer: GraphQLSelectionSet {
        public static let possibleTypes = ["Beer"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("rating", type: .scalar(Double.self)),
          GraphQLField("imageURL", type: .scalar(String.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("abv", type: .scalar(Double.self)),
          GraphQLField("ibu", type: .scalar(Double.self)),
          GraphQLField("type", type: .scalar(String.self)),
          GraphQLField("brewery", type: .nonNull(.object(Brewery.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(rating: Double? = nil, imageUrl: String? = nil, name: String? = nil, abv: Double? = nil, ibu: Double? = nil, type: String? = nil, brewery: Brewery) {
          self.init(unsafeResultMap: ["__typename": "Beer", "rating": rating, "imageURL": imageUrl, "name": name, "abv": abv, "ibu": ibu, "type": type, "brewery": brewery.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var rating: Double? {
          get {
            return resultMap["rating"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "rating")
          }
        }

        public var imageUrl: String? {
          get {
            return resultMap["imageURL"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "imageURL")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var abv: Double? {
          get {
            return resultMap["abv"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "abv")
          }
        }

        public var ibu: Double? {
          get {
            return resultMap["ibu"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "ibu")
          }
        }

        public var type: String? {
          get {
            return resultMap["type"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var brewery: Brewery {
          get {
            return Brewery(unsafeResultMap: resultMap["brewery"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "brewery")
          }
        }

        public struct Brewery: GraphQLSelectionSet {
          public static let possibleTypes = ["Brewery"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("imageURL", type: .scalar(String.self)),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("address", type: .scalar(String.self)),
            GraphQLField("state", type: .scalar(String.self)),
            GraphQLField("county", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(imageUrl: String? = nil, name: String? = nil, address: String? = nil, state: String? = nil, county: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Brewery", "imageURL": imageUrl, "name": name, "address": address, "state": state, "county": county])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var imageUrl: String? {
            get {
              return resultMap["imageURL"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "imageURL")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var address: String? {
            get {
              return resultMap["address"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "address")
            }
          }

          public var state: String? {
            get {
              return resultMap["state"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
            }
          }

          public var county: String? {
            get {
              return resultMap["county"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "county")
            }
          }
        }
      }
    }
  }
}

public final class SearchBeersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query SearchBeers($query: String!) {
      searchBeers(name: $query) {
        __typename
        imageURL
        name
        type
        brewery {
          __typename
          name
        }
      }
    }
    """

  public let operationName = "SearchBeers"

  public var query: String

  public init(query: String) {
    self.query = query
  }

  public var variables: GraphQLMap? {
    return ["query": query]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("searchBeers", arguments: ["name": GraphQLVariable("query")], type: .list(.nonNull(.object(SearchBeer.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchBeers: [SearchBeer]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "searchBeers": searchBeers.flatMap { (value: [SearchBeer]) -> [ResultMap] in value.map { (value: SearchBeer) -> ResultMap in value.resultMap } }])
    }

    public var searchBeers: [SearchBeer]? {
      get {
        return (resultMap["searchBeers"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [SearchBeer] in value.map { (value: ResultMap) -> SearchBeer in SearchBeer(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [SearchBeer]) -> [ResultMap] in value.map { (value: SearchBeer) -> ResultMap in value.resultMap } }, forKey: "searchBeers")
      }
    }

    public struct SearchBeer: GraphQLSelectionSet {
      public static let possibleTypes = ["Beer"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("imageURL", type: .scalar(String.self)),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("type", type: .scalar(String.self)),
        GraphQLField("brewery", type: .nonNull(.object(Brewery.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(imageUrl: String? = nil, name: String? = nil, type: String? = nil, brewery: Brewery) {
        self.init(unsafeResultMap: ["__typename": "Beer", "imageURL": imageUrl, "name": name, "type": type, "brewery": brewery.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var imageUrl: String? {
        get {
          return resultMap["imageURL"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "imageURL")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var type: String? {
        get {
          return resultMap["type"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      public var brewery: Brewery {
        get {
          return Brewery(unsafeResultMap: resultMap["brewery"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "brewery")
        }
      }

      public struct Brewery: GraphQLSelectionSet {
        public static let possibleTypes = ["Brewery"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Brewery", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}
