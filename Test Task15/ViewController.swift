//
//  ViewController.swift
//  Test Task15
//
//  Created by Alibek Kozhambekov on 27.09.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var timer: Timer?
    let searchController = UISearchController(searchResultsController: nil)
    let networkDataFetcher = NetworkDataFetcher()
    var movieResponse: MovieResponse? = nil
    let movieCellIdentifier = "movieCell"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieCell.self, forCellReuseIdentifier: movieCellIdentifier)
        tableView.dataSource = self
        
        setupConstraints()
        setupSearchBar()
    }
}

//MARK: - Constraints

extension ViewController {
    private func setupConstraints() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right)
        }
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
}

//MARK: - TableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as? MovieCell
        cell?.configure((movieResponse?.results[indexPath.row])!)
        return cell ?? UITableViewCell()
    }
}

//MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let urlString = "https://imdb-api.com/en/API/Search/k_ot4zv09t/\(searchText)"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            
            self.networkDataFetcher.fetchMovies(urlString: urlString) { movieResponse in
                guard let movieResponse = movieResponse else { return }
                self.movieResponse = movieResponse
                self.tableView.reloadData()
            }
        })
    }
}


