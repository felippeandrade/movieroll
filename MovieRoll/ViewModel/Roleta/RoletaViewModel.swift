//
//  RoletaViewModel.swift
//  MovieRoll
//
//  Created by Artur Franca on 04/06/22.
//

import Foundation

protocol RoletaViewModelDelegate {
    func carregaFilme(movie: Movie)
    func estrelaVazia(tag: Int)
    func estrelaCheia(tag: Int)
    func botaoGeneroSelecionado(tag: Int)
    func botaoGeneroSemSelecao(tag: Int)
    func exibirAlertaEHabilitarBotao()
    func desabilitarBotaoRoletar()
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
    
    private let plataformas: [Int] = [
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
    
    private let anosDe: [String] = [
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
    
    private var anosAte: [String] {
        return anosDe.filter{ $0 >= dataInicial }
    }
    
    private var anosPickerView: [[String]] { [
        [
            "De:"
        ],
        anosDe,
        [
            "Até:"
        ],
        anosAte
    ]}
    
    private var notasFiltrosEstrela = 0.0
    private var dataInicial = "1930"
    private var dataFinal = "2022"
    private var generosFiltro: [String] = []
    
    private var yearLte: String {
        return "\(dataFinal)-12-31"
    }
    
    private var yearGte: String {
        return "\(dataInicial)-01-01"
    }
    
    private var average: String {
        return String(notasFiltrosEstrela)
    }
    
    private var genres: String {
        var idGenre = ""
        
        for genero in generosFiltro {
            
            idGenre = "%7C\(getGenresId(genero: genero))"
            
        }
        if idGenre.count > 0 {
            idGenre =  String(idGenre.dropFirst(3))
        }
        return idGenre
    }
    
    private var providers: String {
        guard let randomProvider = plataformas.randomElement() else { return "" }
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
    
    var delegate: RoletaViewModelDelegate?
    
    var getPlataformas: [Int] {
        return plataformas
    }
    
    var numberOfItems: Int {
        return plataformas.count
    }
    
    var numberComponents: Int {
        return anosPickerView.count
    }

    //MARK: - Public Methods
    
    func cleanFilters() {
        
        cleanFilterGenres()
        cleanFilterScore()
        cleanFilterDates()
        cleanFilterProviders()
        
    }
    
    func cleanFilterDates() {
        dataInicial = "1930"
        dataFinal = "2022"
        delegate?.cleanDate()
    }
    
    func getImagePlatforms(index: Int) -> String {
        return String(plataformas[index])
    }
    
    func numberOfRows(component: Int) -> Int {
        return anosPickerView[component].count
    }
    
    func titleForRow(row: Int, component: Int) -> String {
        return anosPickerView[component][row]
    }
    
    func getTitleForTextField(row: Int, componente: Int) -> String {
        if componente == 1 {
            dataInicial = anosPickerView[componente][row]
            if dataInicial > dataFinal {
                dataFinal = dataInicial
            }
        } else if componente == 3 {
            dataFinal = anosPickerView[componente][row]
        }
        delegate?.reloadPickerView()
        return "De \(dataInicial) Até \(dataFinal)"
    }
    
    func botaoRoletarMovie() {
        
        delegate?.desabilitarBotaoRoletar()
        service.fetchDiscover(genre: genres, average,  yearLte, yearGte, provider: providers) { movies in
            if movies.count == 0 {
                DispatchQueue.main.async {
                    self.delegate?.exibirAlertaEHabilitarBotao()
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
                        self.delegate?.carregaFilme(movie: movie)
                    }
                }
            }
        }
    }
    
    
    func generoPressionado(_ genero: String?, alpha: Float, tag: Int) {
        guard let genero = genero else { return }
        if alpha == 1 {
            generosFiltro.append(genero)
            delegate?.botaoGeneroSelecionado(tag: tag)
        } else {
            generosFiltro.removeAll { generoFiltro in
                return genero == generoFiltro
            }
            delegate?.botaoGeneroSemSelecao(tag: tag)
        }
    }
    
    func estrelaNotaPressionada(_ tag: Int) {
        for index in 0...4 {
            if index > tag {
                delegate?.estrelaVazia(tag: index)
            } else {
                delegate?.estrelaCheia(tag: index)
            }
        }
        notasFiltrosEstrela = Double(tag) * 1.875
    }
    
    func adicionaPlataformaFiltro(indexPath: IndexPath) {
        let plataforma = plataformas[indexPath.item]
        service.filterProvider.append(plataforma)
    }
    
    func removePlataformaFiltro(indexPath: IndexPath) {
        let plataforma = plataformas[indexPath.item]
        service.filterProvider.removeAll { plataformaFiltro in
            return  plataforma == plataformaFiltro
        }
    }
    
    func verificaFavorito(movie: Movie) -> Bool {
        return coreDataService.pegarListaDeFavoritosNoCoreData().contains { favorito in
            movie.id == favorito.id
        }
    }
    
    func verificaAssistido(movie: Movie) -> Bool {
        return coreDataService.pegarListaDeAssistidosNoCoreData().contains { assistido in
            movie.id == assistido.id
        }
    }
    //MARK: - Private Methods
    
    private func cleanFilterGenres() {
        generosFiltro = []
        delegate?.cleanGenres()
    }
    
    private func cleanFilterScore() {
        notasFiltrosEstrela = 0.0
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
