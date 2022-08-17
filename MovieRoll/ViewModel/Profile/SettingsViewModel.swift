//
//  ConfiguracoesViewModel.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 06/06/22.
//

import Foundation
import FirebaseAuth

protocol SettingsViewModelDelegate {
    func showRouletteAlert()
    func showFavoriteAlert()
    func showWatchedAlert()
    func showDiscconectAlert()
    func navigationBack()
}

class SettingsViewModel {
    //MARK: - Private Properties
    
    private let service: Service = .init()
    private let coreDataService: CoreDataService = .init()
    
    //MARK: - Public Properties
    
    var delegate: SettingsViewModelDelegate?

    //MARK: - Public Methods
    
    func resetRouletteButton() {
        delegate?.showRouletteAlert()
    }
    
    func resetFavoritesButton() {
        delegate?.showFavoriteAlert()
    }
    
    func resetWatchedButton() {
        delegate?.showWatchedAlert()
    }
    
    func discconectAccountButton() {
        
        delegate?.showDiscconectAlert()
    }
    
    func resetRouletteMovies() {
        let roulette = coreDataService.pegarListaDeRoletadosNoCoreData()
        for roulette in roulette {
            coreDataService.removerFilmeRoletadoCoreData(coreDataMovie: roulette)
        }
    }
    
    func resetFavoriteMovies() {
        let favorites = coreDataService.pegarListaDeFavoritosNoCoreData()
        for favorite in favorites {
            coreDataService.removerFilmeFavoritoCoreData(coreDataMovie: favorite)
        }
    }
    
    func resetWatchedMovies() {
        let watched = coreDataService.pegarListaDeAssistidosNoCoreData()
        for watched in watched {
            coreDataService.removerFilmeAssistidoCoreData(coreDataMovie: watched)
        }
    }
    
    func discconectAccount() {
        
        let firebaseAuth = Auth.auth()
     do {
       try firebaseAuth.signOut()
     } catch let signOutError as NSError {
       print("Error signing out: %@", signOutError)
     }
        delegate?.navigationBack()
    }
}
