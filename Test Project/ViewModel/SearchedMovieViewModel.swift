//
//  SearchedMovieViewModel.swift
//  Test Project
//
//  Created by Izhar Hussain on 06/02/2021.
//

import Foundation

class SearchedMovieViewModel{
    
    private var apiService = APIService()
    private var searchedMovies = [Movie]()
    
    func fetchSearchedMoviesData(searchQuery: String, completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        apiService.getSearchedMoviesData(searchQuery: searchQuery) { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.searchedMovies = listOf.movies
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if searchedMovies.count != 0 {
            return searchedMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return searchedMovies[indexPath.row]
    }
}
