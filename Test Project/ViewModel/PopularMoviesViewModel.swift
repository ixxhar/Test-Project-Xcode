//
//  PopularMoviesViewModel.swift
//  Test Project
//
//  Created by Izhar Hussain on 04/02/2021.
//

import Foundation

class PopularMoviesViewModel {
    
    private var apiService = APIService()
    private var popularMovies = [Movie]()
    
    func fetchPopularMoviesData(page: Int, completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        apiService.getPopularMoviesData(page: page) { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.popularMovies = listOf.movies
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return popularMovies[indexPath.row]
    }
}
