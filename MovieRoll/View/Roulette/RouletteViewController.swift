//
//  RoletaViewController.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 26/05/22.
//

import UIKit

class RoletaViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var rouletteButton: UIButton!
    @IBOutlet private var genreButtons: [UIButton]!
    @IBOutlet private weak var releaseDateTextField: UITextField!
    @IBOutlet private weak var platformsCollectionView: UICollectionView!
    @IBOutlet private var starsNoteButton: [UIButton]!
    @IBOutlet weak var rollActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cleanFiltersButton: UIBarButtonItem!

    
    //MARK: - Private Properties
    
    private var viewModel = RoletaViewModel()
    private var releaseDatePickerView = UIPickerView()
    
    //MARK: - Public Properties
    
    //MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        CollectionView()
        inicializaTextField()
        inicializaPickerView()
        
        rollActivityIndicator.isHidden = true
        cleanFiltersButton.tintColor = UIColor(named: "blueMovieRoll")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rouletteButton.isEnabled = true
        rouletteButton.isHidden = false
        
        rollActivityIndicator.isHidden = true
        rollActivityIndicator.stopAnimating()
        
        
    }
    
    //MARK: - Private Methods
    
    private func CollectionView() {
        platformsCollectionView.dataSource = self
        platformsCollectionView.delegate = self
        platformsCollectionView.allowsMultipleSelection = true
    }
    
    private func inicializaTextField() {
        releaseDateTextField.layer.borderWidth = 1
        releaseDateTextField.layer.cornerRadius = 8
        releaseDateTextField.layer.borderColor = UIColor(red: 226.0/255, green: 105.0/255, blue: 64.0/255, alpha: 1.0).cgColor
    }
    
    private func inicializaPickerView() {
        releaseDatePickerView.delegate = self
        releaseDatePickerView.dataSource = self
        
        let okButton = UIBarButtonItem(title: "OK", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePickerView))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.black
        toolBar.isTranslucent = false
        toolBar.tintColor = UIColor(red: 226.0/255, green: 105.0/255, blue: 64.0/255, alpha: 1.0)
        toolBar.sizeToFit()
        
        toolBar.setItems([spaceButton, okButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        releaseDateTextField.inputView = releaseDatePickerView
        releaseDateTextField.inputAccessoryView = toolBar
        
        releaseDatePickerView.setValue(UIColor(red: 226.0/255, green: 105.0/255, blue: 64.0/255, alpha: 1.0), forKeyPath: "textColor")
        releaseDatePickerView.backgroundColor = UIColor.black
    }
    
    @objc private func donePickerView() {
        self.view.endEditing(true)
    }
    
    //MARK: - Actions
    
    @IBAction private func generosBotoesAction(_ sender: UIButton) {
        viewModel.pressedGenre(sender.configuration?.title, alpha: Float(sender.alpha), tag: sender.tag)
    }
    
    @IBAction private func estrelaNotaButtonAction(_ sender: UIButton) {
        viewModel.pressedStarNote(sender.tag)
    }
    
    @IBAction private func limparAnosButtonAction(_ sender: Any) {
        viewModel.cleanFilterDates()
    }
    
    @IBAction private func roletarButtonPressed(_ sender: Any) {
        viewModel.rouletteMovieButton()
    }
    
    @IBAction func cleanFiltersAction(_ sender: Any) {
        viewModel.cleanFilters()
    }
    

}

//MARK: - RoletaViewModel Delegate

extension RoletaViewController: RouletteViewModelDelegate {
    func cleanGenres() {
        for genreButton in genreButtons {
            genreButton.alpha = 1
            genreButton.layer.borderWidth = 0
        }
        
    }
    
    func cleanScore() {
        for starButton in starsNoteButton {
            starButton.configuration?.image = UIImage(systemName: "star")
            starButton.configuration?.baseForegroundColor = .systemYellow
        }
    }
    
    func cleanDate() {
        releaseDateTextField.text = ""
    }
    
    func cleanProviders() {
        guard let items = platformsCollectionView.indexPathsForSelectedItems else { return }
        
        for item in items {
            let cell = platformsCollectionView.cellForItem(at: item)
            cell?.alpha = 1
            cell?.layer.borderWidth = 0
            platformsCollectionView.deselectItem(at: item, animated: true)
        }
    }
    
    func reloadPickerView() {
        releaseDatePickerView.reloadAllComponents()
    }
    
    func disableRouletteButton() {
        rouletteButton.isEnabled = false
        rouletteButton.isHidden = true
        rollActivityIndicator.isHidden = false
        rollActivityIndicator.startAnimating()
    }
    
    func loadMovie(movie: Movie) {
        guard let detalhesFilme = storyboard?.instantiateViewController(withIdentifier: "detalhesFilme") as? MoviesDetailsViewController else { return }
        
        let ehFavorito = viewModel.checksFavorite(movie: movie)
        let foiAssistido = viewModel.checksWatched(movie: movie)
        
        let viewModel = MovieDetailsViewModel(movie: movie, isFavorite: ehFavorito, isWatched: foiAssistido)
        
        detalhesFilme.viewModel = viewModel
        
        navigationController?.pushViewController(detalhesFilme, animated: true)
    }
    
    func showAlertAndEnableButton() {
        let alerta = UIAlertController(title: "Nenhum filme encontrado com os filtros escolhidos!", message: "Altere os filtros e tente novamente", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alerta.addAction(okAction)
        
        present(alerta, animated: true)
        
        rouletteButton.isEnabled = true
        rouletteButton.isHidden = false
        rollActivityIndicator.stopAnimating()
        rollActivityIndicator.isHidden = true
    }
    
    func selectedGenreButton(tag: Int) {
        genreButtons[tag].alpha = 0.60
        genreButtons[tag].layer.cornerRadius = 10
        genreButtons[tag].layer.borderWidth = 3
        genreButtons[tag].layer.borderColor = UIColor.orange.cgColor
    }
    
    func diselectedGenreButton(tag: Int) {
        genreButtons[tag].alpha = 1
        genreButtons[tag].layer.borderWidth = 0
    }
    
    func emptyStar(tag: Int) {
        starsNoteButton[tag].configuration?.image = UIImage(systemName: "star")
        starsNoteButton[tag].configuration?.baseForegroundColor = .systemYellow
        starsNoteButton[tag].transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            self.starsNoteButton[tag].transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
    
    func fullStar(tag: Int) {
        starsNoteButton[tag].configuration?.image = UIImage(systemName: "star.fill")
        starsNoteButton[tag].configuration?.baseForegroundColor = .systemYellow
        starsNoteButton[tag].transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(
            withDuration: 2.0,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.20),
            initialSpringVelocity: CGFloat(6.0),
            options: UIView.AnimationOptions.allowUserInteraction,
            animations: {
                self.starsNoteButton[tag].transform = CGAffineTransform.identity
            },
            completion: { Void in()  }
        )
    }
}

//MARK: - RELEASE DATE: PickerView DataSource & Delegate

extension RoletaViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        viewModel.numberComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.numberOfRows(component: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.titleForRow(row: row, component: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        releaseDateTextField.text = viewModel.getTitleForTextField(row: row, componente: component)
    }
}

//MARK: - PROVIDERS: CollectionView DataSource & Delegate

extension RoletaViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = platformsCollectionView.dequeueReusableCell(withReuseIdentifier: "plataformasCollectionViewCell", for: indexPath) as? PlatformsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(viewModel: viewModel, index: indexPath.item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PlatformsCollectionViewCell else { return }
        viewModel.addFilterPlatform(indexPath: indexPath)
        cell.alpha = 0.60
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.orange.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PlatformsCollectionViewCell else { return }
        viewModel.removePlatformFilter(indexPath: indexPath)
        cell.alpha = 1
        cell.layer.borderWidth = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell.isSelected {
            cell.alpha = 0.60
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 3
            cell.layer.borderColor = UIColor.orange.cgColor
        } else {
            cell.alpha = 1
            cell.layer.borderWidth = 0
        }
    }
}


