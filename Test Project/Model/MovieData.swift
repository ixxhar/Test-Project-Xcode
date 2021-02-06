//
//  MovieModel.swift
//  Test Project
//
//  Created by Izhar Hussain on 03/02/2021.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {

    let id: Int?
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
    let genres: [MovieGenre]?
    let videos: MovieVideoResponse?
    
    public var posterURL: URL {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterImage ?? "")")!
        }

    private enum CodingKeys: String, CodingKey {
        case title, overview, id, genres, videos
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}

public struct MovieGenre: Codable {
    let name: String
}

public struct MovieVideoResponse: Codable {
    public let results: [MovieVideo]
}

public struct MovieVideo: Codable {
    public let id: String
    public let key: String
    public let name: String
    public let site: String
    public let size: Int
    public let type: String
    
    public var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}
