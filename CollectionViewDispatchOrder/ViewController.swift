//
//  ViewController.swift
//  CollectionViewDispatchOrder
//
//  Created by Akira Matsuda on 2023/02/10.
//

import UIKit

class ViewController: UIViewController {
    var collectionView: UICollectionView!
    var button: UIButton!
    var needsLayoutSwitch = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        collectionView = MyCollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        button = UIButton(configuration: UIButton.Configuration.borderedTinted())
        button.setTitle("Reload", for: .normal)
        button.addAction(.init(handler: { [unowned self] _ in
            print("--- Start reloading")
            self.collectionView.reloadData()
            if self.needsLayoutSwitch.isOn {
                self.collectionView.setNeedsLayout()
                self.collectionView.layoutIfNeeded()
            }
            for _ in 0...200000 {} // busy wait
            print("--- Reloaded")
        }), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true

        let label = UILabel()
        label.text = "Needs layout"
        let switchStackView = UIStackView(arrangedSubviews: [
            label,
            needsLayoutSwitch
        ])
        switchStackView.axis = .vertical
        switchStackView.alignment = .center
        switchStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        let stackView = UIStackView(arrangedSubviews: [
            button,
            switchStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection")
        return 100
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("numberOfSections")
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}
