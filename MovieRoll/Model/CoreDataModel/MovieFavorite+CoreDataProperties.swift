//
//  MovieFavorite+CoreDataProperties.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 11/07/22.
//
//

import Foundation
import CoreData


extension MovieFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieFavorite> {
        return NSFetchRequest<MovieFavorite>(entityName: "MovieFavorite")
    }

    @NSManaged public var genreIds: [Int]?
    @NSManaged public var id: Int32
    @NSManaged public var overview: String?
    @NSManaged public var posterImage: Data?
    @NSManaged public var providersId: [Int]?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Float

}

extension MovieFavorite : Identifiable {

}
