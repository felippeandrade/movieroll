//
//  HistoricoCollectionViewCell.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 06/06/22.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets

    @IBOutlet private weak var historyImage: UIImageView!
    
    //MARK: - Public Methods

    func setupCell(viewModel: HistoryCellViewModel) {
        historyImage.image = UIImage(data: viewModel.getImage)
        historyImage.layer.cornerRadius = 10
    }
}
