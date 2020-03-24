//
//  ViewController.swift
//  hw3
//
//  Created by Jakub Petrjanoš on 15/03/2020.
//  Copyright © 2020 Jakub Petrjanoš. All rights reserved.
//

import UIKit

protocol ItemsListDelegate: class {
    func add(item: NumberItem)
}

private let ADD_ITEM_SEGUE_ID = "addItemSegue"

class ItemsListController: UIViewController {
    private var items = [NumberItem]()
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            segue.identifier == ADD_ITEM_SEGUE_ID,
            let addItemController = segue.destination as? AddItemViewController
        {
            addItemController.itemsListDelegate = self
        }
    }
}

extension ItemsListController: ItemsListDelegate {
    func add(item: NumberItem) {
        items.append(item)
        itemsCollectionView.reloadData()
    }
}

private let CELL_REUSE_ID = "cellReuseID"
extension ItemsListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_REUSE_ID, for: indexPath) as? ItemCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.item]
        cell.numberLabel.text = item.number
        cell.numberLabel.textColor = item.color
        
        return cell
    }
}

extension ItemsListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.items.remove(at: indexPath.item)
        self.itemsCollectionView.reloadData()
    }
}

