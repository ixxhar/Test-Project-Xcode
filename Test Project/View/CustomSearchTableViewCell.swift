//
//  CustomSearchTableViewCell.swift
//  Test Project
//
//  Created by Izhar Hussain on 06/02/2021.
//

import UIKit

class CustomSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    private var urlString: String = ""
        
        // Setup movies values
        func setCellWithValuesOf(_ movie:Movie) {
            updateUI(title: movie.title, poster: movie.posterImage)
        }
        
        // Update the UI Views
        private func updateUI(title: String?, poster: String?) {
            
            self.movieLabel.text = title
            
            guard let posterString = poster else {return}
            urlString = "https://image.tmdb.org/t/p/w300" + posterString
            
            guard let posterImageURL = URL(string: urlString) else {
                self.movieImageView.image = UIImage(named: "noImageAvailable")
                return
            }
            
            // Before we download the image we clear out the old one
            self.movieImageView.image = nil
            
            getImageDataFrom(url: posterImageURL)
            
        }
        
        // MARK: - Get image data
        private func getImageDataFrom(url: URL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Handle Error
                if let error = error {
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    // Handle Empty Data
                    print("Empty Data")
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.movieImageView.image = image
                    }
                }
            }.resume()
        }
        
        // MARK: - Convert date format
        func convertDateFormater(_ date: String?) -> String {
            var fixDate = ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let originalDate = date {
                if let newDate = dateFormatter.date(from: originalDate) {
                    dateFormatter.dateFormat = "dd.MM.yyyy"
                    fixDate = dateFormatter.string(from: newDate)
                }
            }
            return fixDate
        }
    }
