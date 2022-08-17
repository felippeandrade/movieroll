//
//  HistoricoCellViewModel.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 06/06/22.
//

import Foundation

class HistoryCellViewModel {
    
    //MARK: - Private Properties
    private let movie: Movie?
    
    init(movie: Movie?) {
        self.movie = movie
    }
    //MARK: - Public Properties
    
    var getImage: Data {
        return movie?.posterImage ?? Data()
    }
}

