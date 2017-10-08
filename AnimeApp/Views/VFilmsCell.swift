//
//  VFilmsCell.swift
//  AnimeApp
//
//  Created by Alper KARATAŞ on 02/10/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit

class VFilmsCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
