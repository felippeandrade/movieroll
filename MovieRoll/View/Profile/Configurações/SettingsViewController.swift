//
//  ConfiguracoesViewController.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 04/06/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - Public Properties
     var viewModel: SettingsViewModel?
    
    lazy var resetRouletteButton: UIButton = {
        var settings = UIButton.Configuration.filled()
        settings.title = "Filmes Roletados"
        settings.baseForegroundColor = .white
        settings.attributedTitle?.font = UIFont(name: "AmsiPro-Bold", size: 17)
        settings.image = UIImage(systemName: "trash")
        settings.image?.withTintColor(.white)
        settings.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12)
        settings.imagePadding = 10
        settings.background.backgroundColor = UIColor(named: "orangeMovieRoll")
        settings.background.cornerRadius = 5
        settings.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 5, bottom: 8, trailing: 0)
        let button = UIButton(configuration: settings)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(resetRouletteButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var resetFavoritesButton: UIButton = {
        var settings = UIButton.Configuration.filled()
        settings.title = "Filmes Favoritos"
        settings.baseForegroundColor = .white
        settings.attributedTitle?.font = UIFont(name: "AmsiPro-Bold", size: 17)
        settings.image = UIImage(systemName: "trash")
        settings.image?.withTintColor(.white)
        settings.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12)
        settings.imagePadding = 10
        settings.background.backgroundColor = UIColor(named: "orangeMovieRoll")
        settings.background.cornerRadius = 5
        settings.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 5, bottom: 8, trailing: 10)
        let button = UIButton(configuration: settings)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(resetFavoritesButtonAction), for: .touchUpInside)
        return button

    }()
    
    lazy var resetWatchedButton: UIButton = {
        var settings = UIButton.Configuration.filled()
        settings.title = "Filmes Assistidos"
        settings.baseForegroundColor = .white
        settings.attributedTitle?.font = UIFont(name: "AmsiPro-Bold", size: 17)
        settings.image = UIImage(systemName: "trash")
        settings.image?.withTintColor(.white)
        settings.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12)
        settings.imagePadding = 10
        settings.background.backgroundColor = UIColor(named: "orangeMovieRoll")
        settings.background.cornerRadius = 5
        let button = UIButton(configuration: settings)
        settings.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 5, bottom: 8, trailing: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(resetWatchedButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var disconnectAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Desconectar Conta", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AmsiPro-Bold", size: 14)
        button.backgroundColor = UIColor(named: "orangeMovieRoll")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(disconnectAccountButtonAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Configurações"
        view.addSubview(resetRouletteButton)
        view.addSubview(resetFavoritesButton)
        view.addSubview(resetWatchedButton)
        view.addSubview(disconnectAccountButton)
        setupConstraints()
        viewModel?.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            resetRouletteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            resetRouletteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            resetRouletteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            
            resetFavoritesButton.topAnchor.constraint(equalTo: resetRouletteButton.bottomAnchor, constant: 16),
            resetFavoritesButton.leadingAnchor.constraint(equalTo: resetRouletteButton.leadingAnchor),
            resetFavoritesButton.trailingAnchor.constraint(equalTo: resetRouletteButton.trailingAnchor),
            
            resetWatchedButton.topAnchor.constraint(equalTo: resetFavoritesButton.bottomAnchor, constant: 16),
            resetWatchedButton.leadingAnchor.constraint(equalTo: resetFavoritesButton.leadingAnchor),
            resetWatchedButton.trailingAnchor.constraint(equalTo: resetFavoritesButton.trailingAnchor),
            
            disconnectAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            disconnectAccountButton.widthAnchor.constraint(equalToConstant: 170),
            disconnectAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        ])
    }
    
    //MARK: - Actions
    
    @objc func resetRouletteButtonAction() {
        viewModel?.resetRouletteButton()
    }
    
    @objc func resetFavoritesButtonAction() {
        viewModel?.resetFavoritesButton()
    }
    
    @objc func resetWatchedButtonAction() {
        viewModel?.resetWatchedButton()
    }
    
    @objc func disconnectAccountButtonAction() {
        viewModel?.resetRouletteMovies()
        viewModel?.resetFavoriteMovies()
        viewModel?.resetWatchedMovies()
        viewModel?.discconectAccountButton()
    }
}

//MARK: - ConfiguracoesViewModel Delegate

extension SettingsViewController: SettingsViewModelDelegate {
    func showRouletteAlert() {
        let alert = UIAlertController(title: "Você está removendo toda lista de filmes roletados.", message: "Tem certeza que deseja remover toda a lista de filmes roletados?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Sim", style: .destructive, handler: {
            alert in
            self.viewModel?.resetRouletteMovies()
        })
        let noAction = UIAlertAction(title: "Nao", style: .default, handler: nil)
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
    
        present(alert, animated: true)
    }
    
    func navigationBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func showFavoriteAlert() {
        let alert = UIAlertController(title: "Você está removendo toda lista de filmes favoritos.", message: "Tem certeza que deseja remover toda a lista de filmes favoritos?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Sim", style: .destructive, handler: {
            alert in
            self.viewModel?.resetFavoriteMovies()
        })
        let noAction = UIAlertAction(title: "Nao", style: .default, handler: nil)
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true)
    }
    
    func showWatchedAlert() {
        let alert = UIAlertController(title: "Você está removendo toda lista de filmes assistidos.", message: "Tem certeza que deseja remover toda a lista de filmes assistidos?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Sim", style: .destructive, handler: {
            alert in
                self.viewModel?.resetWatchedMovies()
        })
        let noAction = UIAlertAction(title: "Nao", style: .default, handler: nil)
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true)
    }
    
    func showDiscconectAlert() {
        let alert = UIAlertController(title: "Você está desconectando sua conta deste app.", message: "Tem certeza que deseja desconectar sua conta deste app?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Sim", style: .destructive, handler: {
            alert in
            self.viewModel?.discconectAccount()
        })
        let noAction = UIAlertAction(title: "Nao", style: .default, handler: nil)
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true)
    }
}

//import SwiftUI
//
//struct ConfiguracaoViewControllerPreviews: PreviewProvider {
//    static var previews: some View {
//        ForEach(deviceNames, id: \.self) { deviceName in
//            ViewControllerPreview {
//                ConfiguracoesViewController()
//            }.previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
//    }
//}
