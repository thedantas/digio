//
//  DigioStoreViewController.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import UIKit
import Kingfisher

final class DigioStoreViewController: CustomViewController {

    // MARK: - UI Components
    private var spotlightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var cashStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let cashLabel: CustomLabel = {
        let label = CustomLabel()
        label.setParts(first: (text: "store_title_cash".localization(), color: .primary),
                       second: (text: "store_subtitle_cash".localization(), color: .gray))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let productLabel: UILabel = {
        let label = UILabel()
        label.text = "store_title_product".localization()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .primaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var productsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let spotlightScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.alwaysBounceVertical = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let productsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.alwaysBounceVertical = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    // MARK: - Properties
    var viewModel: DigioStoreViewModel!

    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }

    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(spotlightScrollView)
        view.addSubview(productsScrollView)
        spotlightScrollView.addSubview(spotlightStackView)
        productsScrollView.addSubview(productsStackView)
        view.addSubview(productLabel)
        view.addSubview(cashLabel)
        view.addSubview(cashStackView)
        makeContraints()
    }

    private func makeContraints() {
        NSLayoutConstraint.activate([
            spotlightScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            spotlightScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            spotlightScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            spotlightScrollView.heightAnchor.constraint(equalToConstant: 170),

            spotlightStackView.topAnchor.constraint(equalTo: spotlightScrollView.topAnchor),
            spotlightStackView.leadingAnchor.constraint(equalTo: spotlightScrollView.leadingAnchor),
            spotlightStackView.trailingAnchor.constraint(equalTo: spotlightScrollView.trailingAnchor),
            spotlightStackView.bottomAnchor.constraint(equalTo: spotlightScrollView.bottomAnchor),
            spotlightStackView.heightAnchor.constraint(equalTo: spotlightScrollView.heightAnchor),

            cashLabel.topAnchor.constraint(equalTo: spotlightScrollView.bottomAnchor, constant: 32),
            cashLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cashLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            cashStackView.topAnchor.constraint(equalTo: cashLabel.bottomAnchor, constant: 16),
            cashStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cashStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cashStackView.heightAnchor.constraint(equalToConstant: 100),

            productLabel.topAnchor.constraint(equalTo: cashStackView.bottomAnchor, constant: 32),
            productLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            productsScrollView.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 16),
            productsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productsScrollView.heightAnchor.constraint(equalToConstant: 150),

            productsStackView.topAnchor.constraint(equalTo: productsScrollView.topAnchor),
            productsStackView.leadingAnchor.constraint(equalTo: productsScrollView.leadingAnchor),
            productsStackView.trailingAnchor.constraint(equalTo: productsScrollView.trailingAnchor),
            productsStackView.bottomAnchor.constraint(equalTo: productsScrollView.bottomAnchor),
            productsStackView.heightAnchor.constraint(equalTo: productsScrollView.heightAnchor)
        ])
    }

    private func setupViewModel() {
        viewModel = DigioStoreViewModel()
        viewModel.fetchStoreData { [weak self] (success, error) in
            DispatchQueue.main.async {
                if success {
                    self?.populateViews()
                } else if let error = error {
                    print(error)
                }
            }
        }
    }

    // MARK: - UI Configuration
    private func populateViews() {
        for item in viewModel.spotlightItems {
            let itemView = SpotlightView(item: item, delegate: self)
            NSLayoutConstraint.activate([
                itemView.widthAnchor.constraint(equalToConstant: 330),
                itemView.heightAnchor.constraint(equalToConstant: 150)
            ])
            spotlightStackView.addArrangedSubview(itemView)
        }

        if let cashItem = viewModel.cashItem {
            let itemView = CashItemView(item: cashItem, delegate: self)
            cashStackView.addArrangedSubview(itemView)
        }

        for item in viewModel.productItems {
            let itemView = ProductView(item: item, delegate: self)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.widthAnchor.constraint(equalToConstant: 130),
                itemView.heightAnchor.constraint(equalToConstant: 130),
            ])
            productsStackView.addArrangedSubview(itemView)
        }
    }
}

// MARK: - Delegate ItemSelectable
extension DigioStoreViewController: ItemSelectable {
    func didSelectItem(_ item: DetailPresentable) {
        showDetailViewController(for: item)
    }
}

// MARK: - Navigation
extension DigioStoreViewController {
    func showDetailViewController(for item: DetailPresentable) {
        let detailVC = DetailViewController()
        detailVC.configure(with: item)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
