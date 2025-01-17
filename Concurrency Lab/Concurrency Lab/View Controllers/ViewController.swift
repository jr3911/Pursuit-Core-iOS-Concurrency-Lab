//
//  ViewController.swift
//  Concurrency Lab
//
//  Created by Jason Ruan on 9/3/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: -- Properties
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
    
    //MARK: -- IBOutlets
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: -- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCountryTableView()
        loadCountries()
    }
    
    //MARK: -- Custom Functions
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
    
    //MARK: -- DataSource Methods
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
    
    //MARK: -- Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = searchText.lowercased()
        print(countriesFilteredBySearch.count)
    }
    
    //MARK: -- Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        switch segueIdentifier {
        case "countryDetailsSegue":
            guard let detailsVC = segue.destination as? CountryDetailsViewController else { return }
            guard let selectedCellPath = countryTableView.indexPathForSelectedRow else { return }
            let selectedCountry = countriesFilteredBySearch[selectedCellPath.row]
            detailsVC.specificCountry = selectedCountry
        default:
            return
        }
    }
    
}

