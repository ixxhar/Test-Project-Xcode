//
//  SelectedMovieViewModel.swift
//  Test Project
//
//  Created by Izhar Hussain on 05/02/2021.
//

import Foundation

class SelectedMovieViewModel {
    private var apiService = APIService()
    
    func fetchPopularMoviesData(movieID: Int, completion: @escaping (Movie) -> ()) {
        
        // weak self - prevent retain cycles
        apiService.getMovieData(movieID: movieID) { (result) in
            
            switch result {
            case .success(let movie):
                completion(movie)
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
    }
}
