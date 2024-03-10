//
//  ProductView.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import UIKit
import Kingfisher

class ProductView: UIView {
    private let imageView = UIImageView()
    private var item: DetailPresentable?
    var delegate: ItemSelectable?

    init(item: ProductItem, delegate: ItemSelectable?) {
        super.init(frame: .zero)
        self.item = item
        self.delegate = delegate
        setupView()
        configure(with: item)
        setupTapGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 5

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }

    func configure(with item: ProductItem) {
        let placeholderImage = UIImage(named: "not_find_icon")

        imageView.kf.setImage(
            with: item.imageURL,
            placeholder: placeholderImage,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ],
            completionHandler: { [weak self] result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    self?.imageView.image = placeholderImage
                }
            }
        )
    }

    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }

    @objc private func handleTap() {
        if let item = self.item {
            delegate?.didSelectItem(item)
        }
    }

}
