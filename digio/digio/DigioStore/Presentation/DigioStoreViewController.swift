//
//  DigioStoreViewController.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import UIKit

class DigioStoreViewController: UIViewController {
    private var spotlightStackView = UIStackView()
    private var cashStackView = UIStackView()
    private var productsStackView = UIStackView()

    var viewModel: DigioStoreViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addStackViewsToHierarchy()
        setupViewModel()
    }

    private func addStackViewsToHierarchy() {
        let spotlightScrollView = UIScrollView()
        let productsScrollView = UIScrollView()

        [spotlightScrollView, productsScrollView].forEach { scrollView in
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)
        }

        spotlightScrollView.addSubview(spotlightStackView)
        productsScrollView.addSubview(productsStackView)

        cashStackView.axis = .horizontal
        cashStackView.distribution = .equalSpacing
        cashStackView.alignment = .center
        cashStackView.spacing = 16
        cashStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cashStackView)

        [spotlightStackView, productsStackView].forEach { stackView in
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            stackView.alignment = .center
            stackView.spacing = 16
            stackView.translatesAutoresizingMaskIntoConstraints = false
        }

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

            cashStackView.topAnchor.constraint(equalTo: spotlightScrollView.bottomAnchor, constant: 20),
            cashStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cashStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cashStackView.heightAnchor.constraint(equalToConstant: 100),

            productsScrollView.topAnchor.constraint(equalTo: cashStackView.bottomAnchor, constant: 20),
            productsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productsScrollView.heightAnchor.constraint(equalToConstant: 150),

            productsStackView.topAnchor.constraint(equalTo: productsScrollView.topAnchor),
            productsStackView.leadingAnchor.constraint(equalTo: productsScrollView.leadingAnchor),
            productsStackView.trailingAnchor.constraint(equalTo: productsScrollView.trailingAnchor),
            productsStackView.bottomAnchor.constraint(equalTo: productsScrollView.bottomAnchor),
            productsStackView.heightAnchor.constraint(equalTo: productsScrollView.heightAnchor)
        ])

        spotlightScrollView.showsHorizontalScrollIndicator = true
        productsScrollView.showsHorizontalScrollIndicator = true

        spotlightScrollView.alwaysBounceVertical = false
        productsScrollView.alwaysBounceVertical = false
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
            let itemView = CashItemView(item: cashItem)
            cashStackView.addArrangedSubview(itemView)
        }

        for item in viewModel.productItems {
            let itemView = ProductView(item: item, delegate: self)
            itemView.translatesAutoresizingMaskIntoConstraints = false


            // Set the width and height constraints to 80 points
            NSLayoutConstraint.activate([
                itemView.widthAnchor.constraint(equalToConstant: 130),
                itemView.heightAnchor.constraint(equalToConstant: 130),
            ])
            productsStackView.addArrangedSubview(itemView)
        }

    }
}
extension DigioStoreViewController: ItemSelectable {
    func didSelectItem(_ item: DetailPresentable) {
        showDetailViewController(for: item)
    }
}

extension DigioStoreViewController {
    func showDetailViewController(for item: DetailPresentable) {
        let detailVC = DetailViewController()
        detailVC.configure(with: item)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
