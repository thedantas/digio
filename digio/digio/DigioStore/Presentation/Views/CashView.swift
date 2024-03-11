//
//  CashView.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import UIKit
import Kingfisher

class CashItemView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 5
        containerView.backgroundColor = .clear
        containerView.clipsToBounds = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private var item: DetailPresentable?
    var delegate: ItemSelectable?

    init(item: CashItem, delegate: ItemSelectable?) {
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
        addSubview(containerView)
        containerView.addSubview(imageView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

    }

    func configure(with item: CashItem) {
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
                case .success:
                    break
                case .failure:
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
