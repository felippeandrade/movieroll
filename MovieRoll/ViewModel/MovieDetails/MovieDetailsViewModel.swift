//
//  DetalhesFilmeViewModel.swift
//  MovieRoll
//
//  Created by Vitor Henrique Barreiro Marinho on 04/06/22.
//

import Foundation

protocol MovieDetailsViewModelDelegate {
    func changeFavoriteMovieButton()
    func changeWatchedMovieButton()
}

class MovieDetailsViewModel {
    
    //MARK: - Private Properties
    
    private let movie: Movie
    private var isFavorite: Bool
    private var isWatched: Bool
    
    private let service: Service = .init()
    
    private let coreDataService: CoreDataService = .init()
    
    private var moviesFavorite: [MovieFavorite] = []
    private var moviesWatched: [MovieWatched] = []
    
    init(movie: Movie, isFavorite: Bool, isWatched: Bool) {
        self.movie = movie
        self.isFavorite = isFavorite
        self.isWatched = isWatched
    }
    
    //MARK: - Public Properties
    
    var delegate: MovieDetailsViewModelDelegate?
    
    var getPosterImage: Data {
        return movie.posterImage
    }
    
    var getName: String {
        return movie.title
    }
    
    var getYear: String {
        return String(movie.releaseDate.dropLast(6))
    }
    
    var getGenre: String {
        var shownGenre = ""
        for generoId in movie.genreIds {
            switch generoId{
            case 28:
                shownGenre += ", Ação"
            case 12:
                shownGenre += ", Aventura"
            case 16:
                shownGenre += ", Animação"
            case 35:
                shownGenre += ", Comédia"
            case 80:
                shownGenre += ", Crime"
            case 18:
                shownGenre += ", Drama"
            case 10751:
                shownGenre += ", Família"
            case 14:
                shownGenre += ", Fantasia"
            case 36:
                shownGenre += ", História"
            case 27:
                shownGenre += ", Terror"
            case 10402:
                shownGenre += ", Música"
            case 9648:
                shownGenre += ", Mistério"
            case 10749:
                shownGenre += ", Romance"
            case 878:
                shownGenre += ", Ficção"
            case 10770:
                shownGenre += ", Cinema TV"
            case 53:
                shownGenre += ", Suspense"
            case 10752:
                shownGenre += ", Guerra"
            case 37:
                shownGenre += ", Faroeste"
            case 99:
                shownGenre += ", Documentário"
            default:
                return ""
            }
        }
        return String(shownGenre.dropFirst(2))
    }
    
    var getMovieNote: String {
        return String(movie.voteAverage)
    }
    
    var getSynopsis: String {
        return movie.overview
    }
    
    var getPlatform: String {
        for provider in service.filterProvider {
            if movie.providersId.contains(provider) {
                return String(provider)
            }
        }
        if movie.providersId.count > 0 {
            return String(movie.providersId[0])
        }
        return ""
    }
    
    var getFavoriteButtonImage: String {
        if isFavorite {
            return "heart"
        } else {
            return "heartnil"
        }
    }
    
    var getWatchedButtonImage: String {
        if isWatched {
            return "checkgreen"
        } else {
            return "check"
        }
    }
    
    //MARK: - Public Methods
    
    func watchedButtonPressed() {
        if isWatched {
            let movieToRemove = getWatchedMovieToRemove(movie: movie)
            coreDataService.removerFilmeAssistidoCoreData(coreDataMovie: movieToRemove)
        } else {
            coreDataService.adicionarFilmeAssistidoCoreData(movie: movie)
            
        }
        isWatched = !isWatched
        delegate?.changeWatchedMovieButton()
    }
    
    func FavoriteButtonPressed() {
        if isFavorite {
            
            let movieToRemove = getFavoriteMovieToRemove(movie: movie)
            coreDataService.removerFilmeFavoritoCoreData(coreDataMovie: movieToRemove)
        } else {
            coreDataService.adicionarFilmeFavoritoCoreData(movie: movie)
        }
        isFavorite = !isFavorite
        delegate?.changeFavoriteMovieButton()
    }
    
    //MARK: - Private Methods
    
    private func getFavoriteMovieToRemove(movie: Movie) -> MovieFavorite {
        moviesFavorite = coreDataService.pegarListaDeFavoritosNoCoreData()
        
        return moviesFavorite.first { movieCoredata in
            movieCoredata.id == movie.id
            
        } ?? MovieFavorite()
    }
    
    private func getWatchedMovieToRemove(movie: Movie) -> MovieWatched {
        moviesWatched = coreDataService.pegarListaDeAssistidosNoCoreData()
        
        return moviesWatched.first { movieCoredata in
            movieCoredata.id == movie.id
            
        } ?? MovieWatched()
    }
    
}
