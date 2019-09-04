//
//  CountryDetailsViewController.swift
//  Concurrency Lab
//
//  Created by Jason Ruan on 9/3/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    //MARK: -- Delegate
    var specificCountry: Country!
    
    //MARK: -- IBOutlets
    @IBOutlet weak var detailCountryNameLabel: UILabel!
    @IBOutlet weak var detailCapitalLabel: UILabel!
    @IBOutlet weak var detailPopulationLabel: UILabel!
    @IBOutlet weak var detailFlagImageView: UIImageView!
    
    //MARK: -- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    //MARK: -- Custom Functions
    private func setUpViews() {
        detailCountryNameLabel.text = specificCountry.name
        detailCapitalLabel.text = "Capital: \(specificCountry.capital ?? "N/A")"
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedCountryPopulation = numberFormatter.string(from: NSNumber(value: specificCountry.population ?? 0))
        detailPopulationLabel.text = "Population: \(formattedCountryPopulation ?? "0")"
    }

}
