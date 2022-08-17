//
//  LancamentosTableViewCell.swift
//  MovieRoll
//
//  Created by Raul Felippe on 04/06/22.
//

import UIKit

class ReleasesTableViewCell: UITableViewCell {
    
    //MARK: - Public Properties

    @IBOutlet  weak var releasesCollectionView: UICollectionView!
    
    //MARK: - private Properties

    private var section: Int?
    private var viewModel: ReleasesViewModel?
    
    //MARK: - Public Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        releasesCollectionView.dataSource = self
        releasesCollectionView.delegate = self
    }
    func config(viewModel: ReleasesViewModel, section: Int) {
        self.viewModel = viewModel
        self.section = section
    }
}

//MARK: - CollectionView DataSource & Delegate

extension ReleasesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems(section: self.section ?? 0) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = releasesCollectionView.dequeueReusableCell(withReuseIdentifier: "idCellCollection", for: indexPath) as? ReleasesCollectionViewCell else { return UICollectionViewCell()}
          
        guard let viewModel = viewModel, let section = section else { return UICollectionViewCell()}
      
        cell.configure(section: section, row: indexPath.row, viewModel: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.setProvidersDataImage(row: indexPath.row, section: collectionView.tag)
    }
}


