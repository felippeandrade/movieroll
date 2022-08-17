//
//  RoletaViewModel.swift
//  MovieRoll
//
//  Created by Artur Franca on 04/06/22.
//

import Foundation

protocol RouletteViewModelDelegate {
    func loadMovie(movie: Movie)
    func emptyStar(tag: Int)
    func fullStar(tag: Int)
    func selectedGenreButton(tag: Int)
    func diselectedGenreButton(tag: Int)
    func showAlertAndEnableButton()
    func disableRouletteButton()
    func reloadPickerView()
    func cleanGenres()
    func cleanScore()
    func cleanDate()
    func cleanProviders()

}

class RoletaViewModel {
    
    //MARK: - Private Properties

    private let service: Service = .init()
    private let coreDataService: CoreDataService = .init()
    
    private let platforms: [Int] = [
        350,
        337,
        307,
        384,
        8,
        531,
        119,
        619,
        227
    ]
    
    private let era: [String] = [
        "2022",
        "2021",
        "2020",
        "2015",
        "2010",
        "2005",
        "2000",
        "1995",
        "1990",
        "1980",
        "1970",
        "1960",
        "1950",
        "1940",
        "1930"
    ]
    
    private var untilTheTime: [String] {
        return era.filter{ $0 >= initialDate }
    }
    
    private var yearsPickerView: [[String]] { [
        [
            "De:"
        ],
        era,
        [
            "Até:"
        ],
        untilTheTime
    ]}
    
    private var noteFilterStar = 0.0
    private var initialDate = "1930"
    private var finalDate = "2022"
    private var genresFilter: [String] = []
    
    private var yearLte: String {
        return "\(finalDate)-12-31"
    }
    
    private var yearGte: String {
        return "\(initialDate)-01-01"
    }
    
    private var average: String {
        return String(noteFilterStar)
    }
    
    private var genres: String {
        var idGenre = ""
        
        for genero in genresFilter {
            
            idGenre = "%7C\(getGenresId(genero: genero))"
            
        }
        if idGenre.count > 0 {
            idGenre =  String(idGenre.dropFirst(3))
        }
        return idGenre
    }
    
    private var providers: String {
        guard let randomProvider = platforms.randomElement() else { return "" }
        var idProvider = "\(randomProvider)"
        
        if service.filterProvider.count > 0 {
            idProvider = ""
            for provider in service.filterProvider {
                idProvider += "%7C\(provider)"
            }
            idProvider =  String(idProvider.dropFirst(3))
        }
        return idProvider
    }
    
    //MARK: - Public Properties
    
    var delegate: RouletteViewModelDelegate?
    
    var getPlatforms: [Int] {
        return platforms
    }
    
    var numberOfItems: Int {
        return platforms.count
    }
    
    var numberComponents: Int {
        return yearsPickerView.count
    }

    //MARK: - Public Methods
    
    func cleanFilters() {
        
        cleanFilterGenres()
        cleanFilterScore()
        cleanFilterDates()
        cleanFilterProviders()
        
    }
    
    func cleanFilterDates() {
        initialDate = "1930"
        finalDate = "2022"
        delegate?.cleanDate()
    }
    
    func getImagePlatforms(index: Int) -> String {
        return String(platforms[index])
    }
    
    func numberOfRows(component: Int) -> Int {
        return yearsPickerView[component].count
    }
    
    func titleForRow(row: Int, component: Int) -> String {
        return yearsPickerView[component][row]
    }
    
    func getTitleForTextField(row: Int, componente: Int) -> String {
        if componente == 1 {
            initialDate = yearsPickerView[componente][row]
            if initialDate > finalDate {
                finalDate = initialDate
            }
        } else if componente == 3 {
            finalDate = yearsPickerView[componente][row]
        }
        delegate?.reloadPickerView()
        return "De \(initialDate) Até \(finalDate)"
    }
    
    func rouletteMovieButton() {
        
        delegate?.disableRouletteButton()
        service.fetchDiscover(genre: genres, average,  yearLte, yearGte, provider: providers) { movies in
            if movies.count == 0 {
                DispatchQueue.main.async {
                    self.delegate?.showAlertAndEnableButton()
                    return
                }
            }
            guard let movie = movies.randomElement() else { return }
            self.service.getImageFromUrl(movie: movie) { image in
                movie.posterImage = image
                self.service.fetchProvidersBy(id: movie.id) { providerId in
                    DispatchQueue.main.async {
                        movie.providersId.append(contentsOf: providerId)
                        self.coreDataService.adicionarFilmeRoletadoCoreData(movie: movie)
                        self.delegate?.loadMovie(movie: movie)
                    }
                }
            }
        }
    }
    
    
    func pressedGenre(_ genero: String?, alpha: Float, tag: Int) {
        guard let genero = genero else { return }
        if alpha == 1 {
            genresFilter.append(genero)
            delegate?.selectedGenreButton(tag: tag)
        } else {
            genresFilter.removeAll { generoFiltro in
                return genero == generoFiltro
            }
            delegate?.diselectedGenreButton(tag: tag)
        }
    }
    
    func pressedStarNote(_ tag: Int) {
        for index in 0...4 {
            if index > tag {
                delegate?.emptyStar(tag: index)
            } else {
                delegate?.fullStar(tag: index)
            }
        }
        noteFilterStar = Double(tag) * 1.875
    }
    
    func addFilterPlatform(indexPath: IndexPath) {
        let platform = platforms[indexPath.item]
        service.filterProvider.append(platform)
    }
    
    func removePlatformFilter(indexPath: IndexPath) {
        let platform = platforms[indexPath.item]
        service.filterProvider.removeAll { platformFilter in
            return  platform == platformFilter
        }
    }
    
    func checksFavorite(movie: Movie) -> Bool {
        return coreDataService.pegarListaDeFavoritosNoCoreData().contains { favorite in
            movie.id == favorite.id
        }
    }
    
    func checksWatched(movie: Movie) -> Bool {
        return coreDataService.pegarListaDeAssistidosNoCoreData().contains { watched in
            movie.id == watched.id
        }
    }
    //MARK: - Private Methods
    
    private func cleanFilterGenres() {
        genresFilter = []
        delegate?.cleanGenres()
    }
    
    private func cleanFilterScore() {
        noteFilterStar = 0.0
        delegate?.cleanScore()
    }
    
    private func cleanFilterProviders() {
        service.filterProvider = []
        delegate?.cleanProviders()
    }

    private func getGenresId(genero: String) -> String {
        for (key, array) in service.genre {
            if array.contains(genero) {
                return key
            }
        }
        return ""
    }
    
}
