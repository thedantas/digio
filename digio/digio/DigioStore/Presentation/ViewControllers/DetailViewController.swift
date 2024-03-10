//
//  DetailViewController.swift
//  digio
//
//  Created by André  Costa Dantas on 10/03/24.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()

    let shadowView = UIView()
    let imageView = UIImageView()

    let titleLabel = UILabel()
    let descriptionTextView = UITextView()

    var detailItem: DetailPresentable?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupShadowView()
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
        configureUI()
    }

    func configure(with item: DetailPresentable) {
        detailItem = item
        imageView.kf.setImage(with: item.imageURL)
        titleLabel.text = item.title
        descriptionTextView.text = item.description
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }

    private func setupShadowView() {
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowRadius = 6
        contentView.addSubview(shadowView)

        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shadowView.heightAnchor.constraint(equalTo: shadowView.widthAnchor, multiplier: 0.56), 
        ])
    }

    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        shadowView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
        ])
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }

    private func setupDescriptionLabel() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.isEditable = false
        descriptionTextView.font = UIFont.systemFont(ofSize: 18)
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.dataDetectorTypes = .link
        descriptionTextView.linkTextAttributes = [
            .foregroundColor: UIColor.blue
        ]
        contentView.addSubview(descriptionTextView)

        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionTextView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
        ])
    }

    private func configureUI() {
        if let item = detailItem {
            configure(with: item)
        }
    }
}
