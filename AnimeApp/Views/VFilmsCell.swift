//
//  VFilmsCell.swift
//  AnimeApp
//
//  Created by Alper KARATAŞ on 02/10/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import UIKit

class VFilmsCell: UICollectionViewCell {
    private static let posterCache = NSCache<NSURL, UIImage>()

    private var posterTask: URLSessionDataTask?
    private var posterURL: URL?

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(white: 0.93, alpha: 1)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterTask?.cancel()
        posterTask = nil
        posterURL = nil
        posterImageView.image = nil
        titleLabel.text = nil
        accessibilityLabel = nil
    }

    func configure(with film: MFilm) {
        titleLabel.text = film.title
        accessibilityLabel = film.title
        isAccessibilityElement = true

        posterTask?.cancel()
        posterTask = nil
        posterURL = nil
        posterImageView.image = nil

        guard let poster = film.image,
            let url = URL(string: poster),
            url.scheme?.lowercased() == "https" else {
                return
        }

        posterURL = url

        if let image = VFilmsCell.posterCache.object(forKey: url as NSURL) {
            posterImageView.image = image
            return
        }

        posterTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil,
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode),
                let data = data,
                let image = UIImage(data: data) else {
                    return
            }

            VFilmsCell.posterCache.setObject(image, forKey: url as NSURL)

            DispatchQueue.main.async {
                guard let cell = self, cell.posterURL == url else {
                    return
                }
                cell.posterImageView.image = image
            }
        }
        posterTask?.resume()
    }

    private func setupUI() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5),

            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4)
        ])
    }
}
