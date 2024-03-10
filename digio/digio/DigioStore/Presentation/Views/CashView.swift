//
//  CashView.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import UIKit
import Kingfisher

class CashItemView: UIView {
    private let imageView = UIImageView()
    private let containerView = UIView() // Contêiner para o imageView que terá o cornerRadius

    init(item: CashItem) {
        super.init(frame: .zero)
        setupView()
        configure(with: item)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        // Adicionar e configurar containerView
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 5
        containerView.backgroundColor = .clear // para que a sombra seja visível
        containerView.clipsToBounds = false // para que a sombra seja visível
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)

        // Restrições para containerView
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        // Adicionar e configurar o imageView
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true // Isso vai aplicar os cantos arredondados à imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView) // Adicionando imageView ao containerView para cantos arredondados

        // Restrições para imageView
        NSLayoutConstraint.activate([
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
                case .success(_):
                    break
                case .failure(_):
                    self?.imageView.image = placeholderImage
                }
            }
        )
    }

}
