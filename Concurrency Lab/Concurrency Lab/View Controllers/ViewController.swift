//
//  ViewController.swift
//  Concurrency Lab
//
//  Created by Jason Ruan on 9/3/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var countries = [Country]() {
        didSet {
            countryTableView.reloadData()
        }
    }

    @IBOutlet weak var countryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryTableView.dataSource = self
        loadCountries()
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
        //placeholder return
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //placeholder return
        return UITableViewCell()
    }

}

