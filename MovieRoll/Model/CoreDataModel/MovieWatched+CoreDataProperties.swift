//
//  MovieWatched+CoreDataProperties.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 11/07/22.
//
//

import Foundation
import CoreData


extension MovieWatched {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieWatched> {
        return NSFetchRequest<MovieWatched>(entityName: "MovieWatched")
    }

    @NSManaged public var id: Int32
    @NSManaged public var genreIds: [Int]?
    @NSManaged public var overview: String?
    @NSManaged public var posterImage: Data?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Float
    @NSManaged public var providersId: [Int]?

}

extension MovieWatched : Identifiable {

}
