//
//  PopularMoviesViewController.swift
//  Test Project
//
//  Created by Izhar Hussain on 21/01/2021.
//

import UIKit

class PopularMoviesViewController: UIViewController{
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var popularMoviesTableView: UITableView!
    private var viewModel = PopularMoviesViewModel()
    
    var page: Int = 1
    var selectedMovieID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPopularMoviesData(page: page)
        
        if page==1 {
            previousButton.alpha = 0
        }else{
            previousButton.alpha = 1
        }
        
    }
    
    private func loadPopularMoviesData(page: Int) {
        viewModel.fetchPopularMoviesData(page: page) { [weak self] in
                self?.popularMoviesTableView.dataSource = self
                self?.popularMoviesTableView.delegate = self
                self?.popularMoviesTableView.reloadData()
            }
        }
    
    @IBAction func loadPreviousPage(_ sender: Any) {
        page -= 1
        print(page)
        
        if page==1 {
            previousButton.alpha = 0
        }else{
            previousButton.alpha = 1
        }
        
        loadPopularMoviesData(page: page)
    }
    
    @IBAction func loadNextPage(_ sender: Any) {
        page += 1
        print(page)
        
        if page==1 {
            previousButton.alpha = 0
        }else{
            previousButton.alpha = 1
        }
        
        loadPopularMoviesData(page: page)
    }
    
}

extension PopularMoviesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        
        selectedMovieID = movie.id
        
        performSegue(withIdentifier: "movieSelected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieSelectedViewController{
            destination.movieID = selectedMovieID
        }
    }
    
}
