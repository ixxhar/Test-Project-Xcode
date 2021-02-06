//
//  SavedMoviesViewController.swift
//  Test Project
//
//  Created by Izhar Hussain on 06/02/2021.
//

import UIKit
import RealmSwift

class SavedMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    var todoList: Results<MovieRealmObject> {
        get {
            return realm.objects(MovieRealmObject.self)
        }
    }
    
    
    @IBOutlet weak var savedMoviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedMoviesTableView.delegate=self
        savedMoviesTableView.dataSource=self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedMovieCell", for: indexPath) as! CustomSavedMovieTableViewCell
        
        let item = todoList[indexPath.row]
        cell.movieTitle.text = item.title
        cell.movieOverview.text = item.overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedMoviesTableView.reloadData()
    }
    
}
