//
//  MovieRealmObject.swift
//  Test Project
//
//  Created by Izhar Hussain on 06/02/2021.
//

import Foundation
import RealmSwift

class MovieRealmObject: Object {
    @objc dynamic var movieID: String?
    @objc dynamic var title: String?
    @objc dynamic var overview: String?
}
