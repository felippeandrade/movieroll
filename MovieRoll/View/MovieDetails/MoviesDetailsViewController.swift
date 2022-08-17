//
//  DetalhesFilmeViewController.swift
//  MovieRoll
//
//  Created by Vitor Henrique Barreiro Marinho on 04/06/22.
//

import UIKit

class MoviesDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet private weak var posterFilme: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var movieNote: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet private weak var platformImageView: UIImageView!
    
    //MARK: - Public Properties

    var viewModel: MovieDetailsViewModel?
    
    //MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customNavigationBar()
        navigationItem.setLeftBarButton(backButton(), animated: true)
        navigationItem.setRightBarButtonItems([checkButton(), favoritesButton()], animated: true)
    }
    
    //MARK: - Private Methods
    
    private func configureUI() {
        guard let viewModel = viewModel else { return }
        
        posterFilme.image = UIImage(data: viewModel.getPosterImage)
        movieNameLabel.text = viewModel.getName
        yearLabel.text = viewModel.getYear
        genreLabel.text = viewModel.getGenre
        movieNote.text = ("\(viewModel.getMovieNote)/10")
        overviewLabel.text = viewModel.getSynopsis
        platformImageView.image = UIImage(named: viewModel.getPlatform)
        platformImageView.layer.cornerRadius = 10
    }
    
    private func customNavigationBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func backButton() -> UIBarButtonItem {
        let backButton = UIBarButtonItem(
            image: UIImage(named: "back"),
            style: .done,
            target: self,
            action: #selector(didTouchBackButton)
        )
        return backButton
    }
    
    private func favoritesButton() -> UIBarButtonItem {
        let favoritesButton = UIBarButtonItem(
            image: UIImage(named: viewModel?.getFavoriteButtonImage ?? "heart"),
            style: .done,
            target: self,
            action: #selector(didTouchFavoritesButton)
        )
        return favoritesButton
    }
    
    private func checkButton() -> UIBarButtonItem {
        let checkButton = UIBarButtonItem(
            image: UIImage(named: viewModel?.getWatchedButtonImage ?? "check"),
            style: .done,
            target: self,
            action: #selector(didTouchCheckButton)
        )
        return checkButton
    }
    
    @objc private func didTouchBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTouchFavoritesButton() {
        viewModel?.FavoriteButtonPressed()
    }
    
    @objc private func didTouchCheckButton() {
        viewModel?.watchedButtonPressed()
    }
    
}

//MARK: - MoviesDetailsViewModel Delegate

extension MoviesDetailsViewController: MovieDetailsViewModelDelegate {
    func changeFavoriteMovieButton() {
        guard let viewModel = viewModel else { return }
        navigationItem.rightBarButtonItems?[1].image = UIImage(named: viewModel.getFavoriteButtonImage)
    }
    
    func changeWatchedMovieButton() {
        guard let viewModel = viewModel else { return }
        navigationItem.rightBarButtonItems?[0].image = UIImage(named: viewModel.getWatchedButtonImage)
    }
}

//MARK: - NavigationController IGestureRecognizerDelegate

extension MoviesDetailsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
