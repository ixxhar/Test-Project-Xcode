//
//  MovieSelectedViewController.swift
//  Test Project
//
//  Created by Izhar Hussain on 03/02/2021.
//

import UIKit
import YoutubePlayer_in_WKWebView
import RealmSwift

class MovieSelectedViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var trailerVideoPlayer: WKYTPlayerView!
    
    var movieID: Int?
    
    private var api = APIService()
    
    private var viewModel = SelectedMovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchPopularMoviesData(movieID: movieID!) { (movieSelected) in
            self.genreLabel.text = ""
            do{
                try self.nameLabel.text = movieSelected.title
            }catch{
                self.nameLabel.text = "N/A"
            }
            do{
                try self.dateLabel.text = movieSelected.year
            }catch{
                self.dateLabel.text = "N/A"
            }
            do{
                try self.overviewLabel.text = movieSelected.overview
            }catch{
                self.overviewLabel.text = "N/A"
            }
            do{
                try self.getImageDataFrom(url: movieSelected.posterURL)}
            catch{
                print("nothing")
            }
            do{
                if (movieSelected.videos?.results.count)! > 0 {
                    try self.trailerVideoPlayer.load(withVideoId: (movieSelected.videos?.results[0].key)!)
                }else{
                    self.trailerVideoPlayer = nil
                }
                
            }catch{
                self.trailerVideoPlayer = nil
            }
            
            for i in movieSelected.genres ?? [MovieGenre]() {
                self.genreLabel.text! += "\(i.name), "
                print(i.name)
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if trailerVideoPlayer != nil {
            trailerVideoPlayer.stopVideo()
        }
        
    }
    
    @IBAction func watchTrailerButton(_ sender: Any) {
        
        if trailerVideoPlayer == nil {
            let alert = UIAlertController(title: "No Video", message: "Trailer Does Not Exists!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            trailerVideoPlayer.playVideo()
        }
        
    }
    
    @IBAction func addToWatchlistButton(_ sender: Any) {
        
        let realm = try! Realm()
        
        let movie = MovieRealmObject()
        movie.movieID = String(movieID!)
        movie.title = nameLabel.text
        movie.overview = overviewLabel.text
        
        let results = realm.objects(MovieRealmObject.self).filter("movieID = '\(movieID!)'")
        
        if results.count > 0{
            print("there")
            
            let alert = UIAlertController(title: "Already Exists", message: "Movie is already in your watchlist  ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            print("not")
            try! realm.write{
                realm.add(movie)
            }
            
            let alert = UIAlertController(title: "Added", message: "Movie has been added to your watchlist  ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
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
                    self.posterImageView.image = image
                }
            }
        }.resume()
    }
    
}
