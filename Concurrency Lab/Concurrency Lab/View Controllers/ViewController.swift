//
//  ViewController.swift
//  Concurrency Lab
//
//  Created by Jason Ruan on 9/3/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    var countries = [Country]() {
        didSet {
            countriesFilteredBySearch = self.countries
        }
    }
    
    var searchString = String() {
        didSet {
            if self.searchString == "" {
                self.countriesFilteredBySearch = self.countries
            } else if self.searchString.count >= 1 {
                countriesFilteredBySearch = [Country]()
                for country in self.countries where country.name!.lowercased().contains(self.searchString) {
                    countriesFilteredBySearch.append(country)
                }
            } else {
                self.countriesFilteredBySearch = self.countries
            }
        }
    }
    
    var countriesFilteredBySearch = [Country]() {
        didSet {
            countryTableView.reloadData()
        }
    }
    
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCountryTableView()
        loadCountries()
    }
    
    private func configureCountryTableView() {
        self.countryTableView.dataSource = self
        self.searchBar.delegate = self
    }
    
    func loadCountries() {
        CountryFetchingService.manager.getAllCountries { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case let .success(fetchedCountries):
                    self.countries = fetchedCountries
                case .failure:
                    return
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesFilteredBySearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countriesFilteredBySearch[indexPath.row]
        guard let cell = countryTableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = "Country: \(country.name ?? "N/A")"
        cell.capitalLabel.text = "Capital: \(country.capital ?? "N/A")"
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedCountryPopulation = numberFormatter.string(from: NSNumber(value: country.population ?? 0))
        cell.populationLabel.text = "Population: \(formattedCountryPopulation ?? "0")"
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = searchText.lowercased()
        print(countriesFilteredBySearch.count)
    }
    
}

