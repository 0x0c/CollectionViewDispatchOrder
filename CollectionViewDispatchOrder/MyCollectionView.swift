//
//  MyCollectionView.swift
//  CollectionViewDispatchOrder
//
//  Created by Akira Matsuda on 2023/02/10.
//

import UIKit

class MyCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews")
    }
}
