//
//  VCFilms.swift
//  AnimeApp
//
//  Created by Alper KARATAŞ on 02/10/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VCFilms: VCBase {
    private let disposeBag = DisposeBag()
    private lazy var viewModel = VMFilms()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 16

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Studio Ghibli Films"
        view.backgroundColor = .white
        setupUI()
        bindFilms()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        let columns: CGFloat = collectionView.bounds.width >= 700 ? 4 : 2
        let insets = layout.sectionInset
        let spacing = layout.minimumInteritemSpacing
        let availableWidth = collectionView.bounds.width - insets.left - insets.right
            - (columns - 1) * spacing

        guard availableWidth > 0 else {
            return
        }

        let cellWidth = floor(availableWidth / columns)
        let itemSize = CGSize(width: cellWidth, height: floor(cellWidth * 1.5 + 60))

        if layout.itemSize != itemSize {
            layout.itemSize = itemSize
        }
    }

    private func setupUI() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.register(VFilmsCell.self, forCellWithReuseIdentifier: "FilmCell")
    }

    private func bindFilms() {
        viewModel.data
            .asObservable()
            .catchErrorJustReturn([])
            .observeOn(MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: "FilmCell", cellType: VFilmsCell.self)) {
                _, film, cell in
                cell.configure(with: film)
            }
            .addDisposableTo(disposeBag)
    }
}
