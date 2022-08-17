//
//  PerfilViewModel.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 03/06/22.
//

import Foundation
import UIKit
import FirebaseAuth

protocol ProfileViewModelDelegate {
    func showMyData()
    func showHistory()
    func showSettings()
    func showHelp()
    func showLogin()
}

class ProfileViewModel {
    
    //MARK: - Private  Properties
    
    
   // private var userPerfil = User(name: "Steve Jobs", image: "profile01")
    
    private var profileOptions = [
        ProfileOptions(
            title: "Meus Dados",
            caption: "Meus dados pessoais.",
            image: "meusdados"
        ),
        ProfileOptions(
            title: "Histórico",
            caption: "Histórico da Roleta, favoritos e assistidos.",
            image: "roleta"
        ),
        ProfileOptions(
            title: "Configurações",
            caption: "Configurações do app.",
            image: "config"
        ),
        ProfileOptions(
            title: "Ajuda",
            caption: "Ajuda do app.",
            image: "ajuda"
        )
    ]
    
    //MARK: - Public Properties
    
    let serviceAuth: ServiceAuth = .init()
    var delegate: ProfileViewModelDelegate?
    
    var numberOfSection: Int {
        return 2
    }
    
    var getMyDataViewModel: MeusDadosViewModel? {
        return MeusDadosViewModel()
    }
    
    var getHistoryViewModel: HistoryViewModel? {
        return HistoryViewModel()
    }
    
    var getSettingsViewMdel: SettingsViewModel? {
        return SettingsViewModel()
    }
    
    //MARK: - Public Methods

    func numberOfRows(section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return profileOptions.count
        }
        return 0
    }
    
    func getImage(indexPath: IndexPath) -> Data {
        if indexPath.section == 0 {
            return ServiceAuth.userProfile.image
        }
        return Data()
    }
    
    func getImage(indexPath: IndexPath) -> String {
        if indexPath.section == 1 {
            return profileOptions[indexPath.row].image
        }
        return String()
    }
    
    func getMaximumSize(indexPath: IndexPath) -> Int {
        if indexPath.section == 0 {
            return 64
        } else {
            return 32
        }
    }
    
    func getCornerRadius(indexPath: IndexPath) -> Int{
        if indexPath.section == 0 {
            return 32
        } else {
            return 5
        }
    }
    
    func getText(indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            if ServiceAuth.userProfile.name != "" {
                return ServiceAuth.userProfile.name
            }
            if ServiceAuth.userProfile.email != "" {
                return ServiceAuth.userProfile.email
            }
            return "Desconectado"
        } else {
            return profileOptions[indexPath.row].title
        }
    }
    
    func getSecondaryText(indexPath: IndexPath) -> String? {
        if indexPath.section == 0 {
            return nil
        } else {
            return profileOptions[indexPath.row].caption
        }
    }
    
    func getDataFromUser() {
        serviceAuth.userInfo()
    }
    
    func optionsFromTableView(index: Int) {
        if Auth.auth().currentUser != nil {
            if index == 0 {
                delegate?.showMyData()
            }
            if index == 1 {
                delegate?.showHistory()
            }
            if index == 2 {
                delegate?.showSettings()
            }
            if index == 3 {
                delegate?.showHelp()
            }
        } else {
            delegate?.showLogin()
        }
    }
}
