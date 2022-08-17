//
//  User.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 03/06/22.
//

import UIKit

class User {
    var name: String
    var email: String
    var image: Data
    
    init(name: String, email: String, image: Data) {
        self.name = name
        self.email = email
        self.image = image
    }
}
