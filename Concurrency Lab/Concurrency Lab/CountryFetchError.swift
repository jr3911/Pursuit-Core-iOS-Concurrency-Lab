//
//  CountryFetchErrors.swift
//  Concurrency Lab
//
//  Created by Jason Ruan on 9/3/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

enum CountryFetchError: Error, CustomStringConvertible {
    case badURL
    case responseError(Error)
    case noURLResponse
    case noData
    case badURLResponse(Int)
    
    var description: String {
        switch self {
        case .badURL:
            return "Invalid URL"
        case let .responseError(error):
            return "Response Error: \(error)"
        case.noURLResponse:
            return "No URL response"
        case .noData:
            return "No data received"
        case let .badURLResponse(statusCode):
            return "URL Response error: \(statusCode)"
        }
    }
}

