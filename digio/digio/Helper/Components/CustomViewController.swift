//
//  CustomViewController.swift
//  digio
//
//  Created by André  Costa Dantas on 10/03/24.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.isTranslucent = false
            navigationBar.barTintColor = .primaryColor
            navigationBar.tintColor = UIColor.white
            navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }

        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false

        let imageView = UIImageView(image: UIImage(named: "logo_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "name_title".localization()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false

        titleView.addSubview(imageView)
        titleView.addSubview(label)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleView)
        navigationController?.navigationBar.backgroundColor = .primaryColor
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: titleView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            titleView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            titleView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}
