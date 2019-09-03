//
//  Country.swift
//  Concurrency Lab
//
//  Created by Jason Ruan on 9/3/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String?
    let capital: String?
    let population: Int?
    let flag: URL?
}
