//
//  CountryError.swift
//  Concurrency Lab
//
//  Created by Jason Ruan on 9/3/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

enum CountryError: Error {
    case networkError(NetworkError)
    case jsonDecodingError(Error)
    
    var description: String {
        switch self {
        case let .networkError(networkError):
            return "Network Error: \(networkError)"
        case let .jsonDecodingError(decodingError):
            return "Decoding Error: \(decodingError)"
        }
    }
    
}
