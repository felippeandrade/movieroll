//
//  HistoricoViewModel.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 06/06/22.
//

import Foundation
import UIKit

protocol HistoryViewModelDelegate {
    
    func reloadCollectionView()
}

class HistoryViewModel {
    
    //MARK: - Private Properties
    
    private let coreDataService = CoreDataService()
    
    private var filteredRollMovies: [MovieRolls] = []
    private var filteredFavoriteMovies: [MovieFavorite] = []
    private var filteredWatchedMovies: [MovieWatched] = []
    
    
    //MARK: - Public Properties
    
    var delegate: HistoryViewModelDelegate?

    //MARK: - Public Methods
    
    func loadMovies(){
        filteredRollMovies = coreDataService.pegarListaDeRoletadosNoCoreData()
        filteredFavoriteMovies = coreDataService.pegarListaDeFavoritosNoCoreData()
        filteredWatchedMovies = coreDataService.pegarListaDeAssistidosNoCoreData()

    }
    
    func searchResults(searchController: UISearchController){
        
        guard let searchText = searchController.searchBar.text else { return }
        
        let rollMovies = coreDataService.pegarListaDeRoletadosNoCoreData()
        let FavoriteMovies = coreDataService.pegarListaDeFavoritosNoCoreData()
        let WatchedMovies = coreDataService.pegarListaDeAssistidosNoCoreData()
        
        if searchText.isEmpty{
            filteredRollMovies = rollMovies
            filteredFavoriteMovies = FavoriteMovies
            filteredWatchedMovies = WatchedMovies
            
        }else {
            
            filteredRollMovies = rollMovies.filter { movie in
                movie.title?.range(of: searchText, options: .caseInsensitive) != nil
            }
            filteredFavoriteMovies = FavoriteMovies.filter { movie in
                movie.title?.range(of: searchText, options: .caseInsensitive) != nil
            }
            
            filteredWatchedMovies = WatchedMovies.filter { movie in
                movie.title?.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        delegate?.reloadCollectionView()
        
    }
    
    func numberOfItems(segmentedControlIndex: Int) -> Int {
        if segmentedControlIndex == 0 {
            let roulette = filteredRollMovies
            return roulette.count
        }
        if segmentedControlIndex == 1 {
            let favorites = filteredFavoriteMovies
            return favorites.count
        }
        if segmentedControlIndex == 2 {
            let watched = filteredWatchedMovies
            return watched.count
        }
        return 0
    }
    
    func returnsMovie(indexMovie: Int, indexSegmenterController: Int) -> Movie {
        if indexSegmenterController == 0 {
            let rouletteMovie = filteredRollMovies
            return coreDataMovieToMovie(coreDataMovie: rouletteMovie[indexMovie])
        }
        if indexSegmenterController == 1 {
            let favoriteMovie = filteredFavoriteMovies
            return coreDataMovieToMovie(coreDataMovie: favoriteMovie[indexMovie])
        }
        if indexSegmenterController == 2 {
            let watchedMovie = filteredWatchedMovies
            return coreDataMovieToMovie(coreDataMovie: watchedMovie[indexMovie])
        }
        return Movie()
    }
    
    func getCellViewModel(indexPath: IndexPath, segmentedControlIndex: Int) -> HistoryCellViewModel? {
        var movie : Movie?
        
        if segmentedControlIndex == 0 {
            let rouletteMovie = filteredRollMovies
            movie = coreDataMovieToMovie(coreDataMovie: rouletteMovie[indexPath.row])
        }
        if segmentedControlIndex == 1 {
            let favoriteMovie = filteredFavoriteMovies
            movie = coreDataMovieToMovie(coreDataMovie: favoriteMovie[indexPath.row])
        }
        if segmentedControlIndex == 2 {
            let watchedMovie = filteredWatchedMovies
            movie = coreDataMovieToMovie(coreDataMovie: watchedMovie[indexPath.row])
        }
        return HistoryCellViewModel(movie: movie)
    }
    
    func checksFavorite(movie: Movie) -> Bool {
        return filteredFavoriteMovies.contains { favorite in
            favorite.id == movie.id
        }
    }
    
    func checksWatched(movie: Movie) -> Bool {
        return filteredWatchedMovies.contains { watched in
            movie.id == watched.id
        }
    }
    
    //MARK: - Private Methods
    
    private func coreDataMovieToMovie(coreDataMovie: MovieRolls) -> Movie {
        let movie = Movie()
        
        movie.id = Int(coreDataMovie.id)
        movie.title = coreDataMovie.title ?? ""
        movie.overview = coreDataMovie.overview ?? ""
        movie.posterImage = coreDataMovie.posterImage ?? Data()
        movie.voteAverage = coreDataMovie.voteAverage
        movie.releaseDate = coreDataMovie.releaseDate ?? ""
        movie.genreIds = coreDataMovie.genreIds ?? []
        movie.providersId = coreDataMovie.providersId ?? []
        
        return movie
    }
    
   private func coreDataMovieToMovie(coreDataMovie: MovieFavorite) -> Movie {
        let movie = Movie()
        
        movie.id = Int(coreDataMovie.id)
        movie.title = coreDataMovie.title ?? ""
        movie.overview = coreDataMovie.overview ?? ""
        movie.posterImage = coreDataMovie.posterImage ?? Data()
        movie.voteAverage = coreDataMovie.voteAverage
        movie.releaseDate = coreDataMovie.releaseDate ?? ""
        movie.genreIds = coreDataMovie.genreIds ?? []
        movie.providersId = coreDataMovie.providersId ?? []
        
        return movie
    }
    
   private func coreDataMovieToMovie(coreDataMovie: MovieWatched) -> Movie {
        let movie = Movie()
        
        movie.id = Int(coreDataMovie.id)
        movie.title = coreDataMovie.title ?? ""
        movie.overview = coreDataMovie.overview ?? ""
        movie.posterImage = coreDataMovie.posterImage ?? Data()
        movie.voteAverage = coreDataMovie.voteAverage
        movie.releaseDate = coreDataMovie.releaseDate ?? ""
        movie.genreIds = coreDataMovie.genreIds ?? []
        movie.providersId = coreDataMovie.providersId ?? []
        
        return movie
    }
    
}
