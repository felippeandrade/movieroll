//
//  PlataformasCollectionViewCell.swift
//  MovieRoll
//
//  Created by Artur Franca on 04/06/22.
//

import UIKit

class PlatformsCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlets

    @IBOutlet private weak var platformImageView: UIImageView!
    
    //MARK: - Public Methods

    func configureCell(viewModel: RoletaViewModel, index: Int) {
        platformImageView.image = UIImage(named: viewModel.getImagePlatforms(index: index))
        platformImageView.layer.cornerRadius = 10
    }
}


