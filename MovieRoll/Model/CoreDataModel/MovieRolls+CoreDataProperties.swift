//
//  MovieRolls+CoreDataProperties.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 11/07/22.
//
//

import Foundation
import CoreData


extension MovieRolls {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieRolls> {
        return NSFetchRequest<MovieRolls>(entityName: "MovieRolls")
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

extension MovieRolls : Identifiable {

}
