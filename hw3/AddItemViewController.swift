//
//  AddItemController.swift
//  hw3
//
//  Created by Jakub Petrjanoš on 15/03/2020.
//  Copyright © 2020 Jakub Petrjanoš. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    private var numberItem = NumberItem()
    weak var itemsListDelegate: ItemsListDelegate?
    
    @IBAction func generateRed(_ sender: Any) {
        numberItem.color = UIColor.red
        numberItem.number = String(Int.random(in: 1..<11))
        
        itemsListDelegate?.add(item: numberItem)
        dismiss(animated: true)
    }
    
    
    @IBAction func generateGreen(_ sender: Any) {
        numberItem.color = UIColor.green
        numberItem.number = String(Int.random(in: 1..<51))
        
        itemsListDelegate?.add(item: numberItem)
        dismiss(animated: true)
    }
    
    @IBAction func generateBlue(_ sender: Any) {
        numberItem.color = UIColor.blue
        numberItem.number = String(Int.random(in: 11..<49))
        
        itemsListDelegate?.add(item: numberItem)
        dismiss(animated: true)
    }
}
