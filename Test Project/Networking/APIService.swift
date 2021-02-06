//
//  MovieRequest.swift
//  Test Project
//
//  Created by Izhar Hussain on 03/02/2021.
//

import Foundation

class APIService {

    private var dataTask: URLSessionDataTask?

    func getPopularMoviesData(page:Int, completion: @escaping (Result<MoviesData, Error>) -> Void) {

        let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=4a2cb1ed86a719cf595ec7833fe0aaa4&language=en-US&page=\(page)"

        guard let url = URL(string: popularMoviesURL) else {return}

        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in

            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")

            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }

            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)

                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }

        }
        dataTask?.resume()
    }
    
    func getMovieData(movieID:Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        
        let movieDataURL = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=4a2cb1ed86a719cf595ec7833fe0aaa4&append_to_response=videos"
        
        guard let url = URL(string: movieDataURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in

            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")

            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }

            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Movie.self, from: data)

                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }

        }
        dataTask?.resume()
        
    }
    
    func getSearchedMoviesData(searchQuery: String, completion: @escaping (Result<MoviesData, Error>) -> Void) {

        let searchMoviesURL = "https://api.themoviedb.org/3/search/movie?api_key=4a2cb1ed86a719cf595ec7833fe0aaa4&language=en-US&query=\(searchQuery)"

        guard let url = URL(string: searchMoviesURL) else {return}

        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in

            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")

            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }

            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)

                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }

        }
        dataTask?.resume()
    }
    
}
