//
//  PlataformasCollectionViewCell.swift
//  MovieRoll
//
//  Created by Artur Franca on 04/06/22.
//

import UIKit

class PlataformasCollectionViewCell: UICollectionViewCell {
    //MARK: - Private Properties

    @IBOutlet private weak var plataformaImageView: UIImageView!
    
    //MARK: - Public Methods

    func configuraCell(viewModel: RoletaViewModel, index: Int) {
        plataformaImageView.image = UIImage(named: viewModel.getImagePlataformas(index: index))
        plataformaImageView.layer.cornerRadius = 10
    }
}


