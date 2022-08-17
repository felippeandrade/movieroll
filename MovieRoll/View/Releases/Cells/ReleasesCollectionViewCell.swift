//
//  LancamentosCollectionViewCell.swift
//  MovieRoll
//
//  Created by Raul Felippe on 04/06/22.
//

import UIKit

class ReleasesCollectionViewCell: UICollectionViewCell {
    //MARK: - Private Properties

    @IBOutlet private weak var movieImageUIImageView: UIImageView!
  
    //MARK: - Public Methods

    func configure(section: Int, row: Int, viewModel: ReleasesViewModel) {
//        imagemFilmeUIImageView.image = UIImage(data: viewModel.getImage(section: section, row: row))
        movieImageUIImageView.load(url: viewModel.getImage(section: section, row: row), placeholder: UIImage())
        movieImageUIImageView.layer.cornerRadius = 10
    }
}
