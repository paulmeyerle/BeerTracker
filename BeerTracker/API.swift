//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class HomeBeweriesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query HomeBeweries {
      allBreweries {
        __typename
        name
        address
        state
        county
      }
    }
    """

  public let operationName = "HomeBeweries"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allBreweries", type: .list(.nonNull(.object(AllBrewery.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allBreweries: [AllBrewery]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "allBreweries": allBreweries.flatMap { (value: [AllBrewery]) -> [ResultMap] in value.map { (value: AllBrewery) -> ResultMap in value.resultMap } }])
    }

    public var allBreweries: [AllBrewery]? {
      get {
        return (resultMap["allBreweries"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [AllBrewery] in value.map { (value: ResultMap) -> AllBrewery in AllBrewery(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AllBrewery]) -> [ResultMap] in value.map { (value: AllBrewery) -> ResultMap in value.resultMap } }, forKey: "allBreweries")
      }
    }

    public struct AllBrewery: GraphQLSelectionSet {
      public static let possibleTypes = ["Brewery"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("address", type: .scalar(String.self)),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("county", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, address: String? = nil, state: String? = nil, county: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Brewery", "name": name, "address": address, "state": state, "county": county])
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
