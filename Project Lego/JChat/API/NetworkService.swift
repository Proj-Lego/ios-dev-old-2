//
//  NetworkService.swift
//  Lego
//
//  Created by Abhinav Pottabathula on 1/14/20.
//  Copyright © 2020 lego. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "e8kwI-bXlIlOwnVbaStjwjsVhEpybJOnznM9GO0_tlBrkN-GSTYKTZsSQLHFTG1Of3B3CPA-AVfaX7oeb6SJYA8gB6OpyV9OURxL69nNhVzT49JUMSb4AL3UDOX_XXYx"

enum YelpService {
    enum BusinessesProvider: TargetType {
        case search(lat: Double, long: Double)
        case details(id: String)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }

        var path: String {
            switch self {
            case .search:
                return "/search"
            case let .details(id):
                return "/\(id)"
            }
        }

        var method: Moya.Method {
            return .get
        }

        var sampleData: Data {
            return Data()
        }

        var task: Task {
            switch self {
            case let .search(lat, long):
                return .requestParameters(
                    parameters: ["latitude": lat, "longitude": long, "limit": 10, "categories":"nightlife"], encoding: URLEncoding.queryString)
            case .details:
                return .requestPlain
            }
            
        }

        var headers: [String : String]? {
            return ["Authorization": "Bearer \(apiKey)"]
        }
    }
}
