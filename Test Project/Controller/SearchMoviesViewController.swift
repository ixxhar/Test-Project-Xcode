//
//  SearchMoviesViewController.swift
//  Test Project
//
//  Created by Izhar Hussain on 03/02/2021.
//

import UIKit

class SearchMoviesViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var searchedMoviesTableView: UITableView!
    
    private var viewModel = SearchedMovieViewModel()
    
    var selectedMovieID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchBar.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadPopularMoviesData(searchQuery: movieSearchBar.text!)
    }
    
    private func loadPopularMoviesData(searchQuery: String) {
        viewModel.fetchSearchedMoviesData(searchQuery: searchQuery) { [weak self] in
                self?.searchedMoviesTableView.dataSource = self
                self?.searchedMoviesTableView.delegate = self
                self?.searchedMoviesTableView.reloadData()
            }
        }
    
}

extension SearchMoviesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCellForSearch", for: indexPath) as! CustomSearchTableViewCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        
        selectedMovieID = movie.id
        
        performSegue(withIdentifier: "movieSearchedSelected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieSelectedViewController{
            destination.movieID = selectedMovieID
        }
    }
}
