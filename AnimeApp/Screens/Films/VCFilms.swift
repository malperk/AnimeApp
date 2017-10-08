//
//  VCFilms.swift
//  AnimeApp
//
//  Created by Alper KARATAŞ on 02/10/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit
import PureLayout
import RxSwift
import RxCocoa

class VCFilms: VCBase {
    private let disposeBag = DisposeBag()
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: view.frame, collectionViewLayout: self.layout())
    }()
    lazy var viewModel = VMFilms()

    override func loadView() {
        super.loadView()
        setupUI()
    }
    private func setupUI() {
        view.addSubview(self.collectionView)
        collectionView.register(VFilmsCell.self, forCellWithReuseIdentifier: "reuseIdentifier")
        viewModel.data.asObservable().catchErrorJustReturn([])
            .bind(to: self.collectionView.rx.items(cellIdentifier: "reuseIdentifier", cellType: VFilmsCell.self))
            { row, element, cell in
                //cell.
            cell.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        }.addDisposableTo(disposeBag)
        

    }

    private func layout() -> UICollectionViewLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        return layout
    }
}

