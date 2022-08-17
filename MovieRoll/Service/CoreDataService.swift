//
//  CoreDataService.swift
//  MovieRoll
//
//  Created by Raul Felippe on 25/06/22.
//

import Foundation
import UIKit
import CoreData

class CoreDataService {
    //MARK: - Private Properties

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK: - Public Methods
    
    //mark: Funcs Adicionar Filme
    func adicionarFilmeFavoritoCoreData(movie: Movie) {
        let coreDataMovie: MovieFavorite = .init(context: context)
        
        coreDataMovie.id = Int32(movie.id)
        coreDataMovie.title = movie.title
        coreDataMovie.overview = movie.overview
        coreDataMovie.posterImage = movie.posterImage
        coreDataMovie.voteAverage = movie.voteAverage
        coreDataMovie.releaseDate = movie.releaseDate
        coreDataMovie.genreIds = movie.genreIds
        coreDataMovie.providersId = movie.providersId
        
        salvarContexto()
    }
    
    func adicionarFilmeAssistidoCoreData(movie: Movie) {
        let coreDataMovie: MovieWatched = .init(context: context)
        
        coreDataMovie.id = Int32(movie.id)
        coreDataMovie.title = movie.title
        coreDataMovie.overview = movie.overview
        coreDataMovie.posterImage = movie.posterImage
        coreDataMovie.voteAverage = movie.voteAverage
        coreDataMovie.releaseDate = movie.releaseDate
        coreDataMovie.genreIds = movie.genreIds
        coreDataMovie.providersId = movie.providersId
        
        salvarContexto()
    }
    
    func adicionarFilmeRoletadoCoreData(movie: Movie) {
        let coreDataMovie: MovieRolls = .init(context: context)

        coreDataMovie.id = Int32(movie.id)
        coreDataMovie.title = movie.title
        coreDataMovie.overview = movie.overview
        coreDataMovie.posterImage = movie.posterImage
        coreDataMovie.voteAverage = movie.voteAverage
        coreDataMovie.releaseDate = movie.releaseDate
        coreDataMovie.genreIds = movie.genreIds
        coreDataMovie.providersId = movie.providersId

        salvarContexto()
    }
    
    //mark: Funcs pegar lista Filmes
    func pegarListaDeFavoritosNoCoreData() -> [MovieFavorite] {
        do {
            return try context.fetch(MovieFavorite.fetchRequest())
        } catch {
            print(error)
        }
        return []
    }
    
    func pegarListaDeAssistidosNoCoreData() -> [MovieWatched] {
        do {
            return try context.fetch(MovieWatched.fetchRequest())
        } catch {
            print(error)
        }
        return []
    }
    
    func pegarListaDeRoletadosNoCoreData() -> [MovieRolls] {
        do {
            return try context.fetch(MovieRolls.fetchRequest())
        } catch {
            print(error)
        }
        return []
    }
    
    //mark: Funcs remover filme
    func removerFilmeFavoritoCoreData(coreDataMovie: MovieFavorite) {
        context.delete(coreDataMovie)
        salvarContexto()
    }
    
    func removerFilmeAssistidoCoreData(coreDataMovie: MovieWatched) {
        context.delete(coreDataMovie)
        salvarContexto()
    }
    
    func removerFilmeRoletadoCoreData(coreDataMovie: MovieRolls) {
        context.delete(coreDataMovie)
        salvarContexto()
    }
    
    //MARK: - Private Methods

    private func salvarContexto() {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()
    }
}
