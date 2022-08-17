//
//  LancamentosTableViewModel.swift
//  MovieRoll
//
//  Created by Raul Felippe on 04/06/22.
//

import Foundation

protocol ReleasesViewModelDelegate {
    func didSelectItem (movie: Movie)
}

class ReleasesViewModel {
    //MARK: - Private Properties
    
    private let service: Service = .init()
    private let coreDataService: CoreDataService = .init()
    
    private var ReleasedMovies: [String: [Movie]] = [
        "28": [],
        "878": [],
        "53": [],
        "27": [],
        "12": [],
        "18": [],
        "10751": [],
        "10749": [],
        "35": []
    ]
    
    //MARK: - Public Properties
    
    var delegate: ReleasesViewModelDelegate?

    var numberOfRows: Int {
            return 1
    }
    
    var numberOfSection: Int {
        guard let first = ReleasedMovies.values.first  else { return 0 }
        if first.count > 0 {
            return ReleasedMovies.count
        }
        return 0
    }
    
    //MARK: - Public Methods
    
    func numberOfItems(section: Int) -> Int {
        return Array(ReleasedMovies.values)[section].count

    }
    
    func returnsTitle(section: Int) -> String {
        let chave = Array(ReleasedMovies.keys)[section]
        return service.genre[chave] ?? ""
    }
    
    func returnsMovie(row: Int, section: Int) -> Movie {
    
        return Array(ReleasedMovies.values)[section][row]
    }
    
    func setProvidersDataImage(row: Int, section: Int) {
        let group = DispatchGroup()
        
        let movie = Array(ReleasedMovies.values)[section][row]
        
        group.enter()
        setProviders(movie: movie) {
            group.leave()
        }
   
        group.enter()
        setDataImage(movie: movie) {
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.delegate?.didSelectItem(movie: movie)
        }

    }

    func checksFavorite(movie: Movie) -> Bool {
        return coreDataService.pegarListaDeFavoritosNoCoreData().contains { favorito in
            movie.id == favorito.id
        }
    }
    
    func checksWatched(movie: Movie) -> Bool {
        return coreDataService.pegarListaDeAssistidosNoCoreData().contains { assistido in
            movie.id == assistido.id
        }
    }
    
    func loadMovies(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        for genre in ReleasedMovies.keys {
            group.enter()
            service.fetchDiscoverReleases(genre: genre) { filmes in
                self.ReleasedMovies[genre] = filmes

                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func getImage(section: Int, row: Int) -> URL {
        let movie = Array(ReleasedMovies.values)[section][row]
        let url = service.getUrl(movie: movie)
        
        return url
    }
    
    //MARK: - Private Methods
    
    private func setProviders(movie: Movie, completion: @escaping () -> Void) {
        service.fetchProvidersBy(id: movie.id) { providers in
                movie.providersId = providers
            completion()
        }
    }
    
    private func setDataImage(movie: Movie, completion: @escaping () -> Void) {
        service.getImageFromUrl(movie: movie) { image in
            movie.posterImage = image
            completion()
        }
    }

}
