//
//  SpotlightView.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import UIKit
import Kingfisher

class SpotlightView: UIView {
    private let imageView = UIImageView()
    private let shadowView = UIView()
    private var item: DetailPresentable?
    var delegate: ItemSelectable?

    init(item: SpotlightItem, delegate: ItemSelectable?) {
        super.init(frame: .zero)
        self.item = item
        self.delegate = delegate
        setupShadowView()
        setupImageView()
        configure(with: item)
        setupTapGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupShadowView() {
        addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.backgroundColor = .clear
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowView.layer.shadowOpacity = 0.1
        shadowView.layer.shadowRadius = 4

        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupImageView() {
        shadowView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor)
        ])
    }

    func configure(with item: SpotlightItem) {
        let placeholderImage = UIImage(named: "not_find_icon")

        imageView.kf.setImage(
            with: item.bannerURL,
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
