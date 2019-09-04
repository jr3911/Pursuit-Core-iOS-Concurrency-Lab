//
//  CountryDetailsViewController.swift
//  Concurrency Lab
//
//  Created by Jason Ruan on 9/3/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    var specificCountry: Country!
    
    @IBOutlet weak var detailCountryNameLabel: UILabel!
    @IBOutlet weak var detailCapitalLabel: UILabel!
    @IBOutlet weak var detailPopulationLabel: UILabel!
    @IBOutlet weak var detailFlagImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        detailCountryNameLabel.text = specificCountry.name
        detailCapitalLabel.text = "Capital: \(specificCountry.capital ?? "N/A")"
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedCountryPopulation = numberFormatter.string(from: NSNumber(value: specificCountry.population ?? 0))
        detailPopulationLabel.text = "Population: \(formattedCountryPopulation ?? "0")"
    }

}
