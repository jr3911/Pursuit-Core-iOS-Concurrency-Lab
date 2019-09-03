//
//  Country.swift
//  Concurrency Lab
//
//  Created by Jason Ruan on 9/3/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

struct Countries: Codable {
    let countries: [Country]
    
    static func getAllCountries(from data: Data) throws -> [Country] {
        do {
            let countries = try JSONDecoder().decode([Country].self, from: data)
            return countries
        } catch let decodeError {
            throw decodeError
        }
    }
}

struct Country: Codable {
    let name: String?
    let capital: String?
    let population: Int?
    let flag: URL?
}
