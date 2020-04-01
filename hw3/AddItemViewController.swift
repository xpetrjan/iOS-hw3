//
//  AddItemController.swift
//  hw3
//
//  Created by Jakub Petrjanoš on 15/03/2020.
//  Copyright © 2020 Jakub Petrjanoš. All rights reserved.
//

import UIKit
import Alamofire

class AddItemViewController: UIViewController {
    weak var itemsListDelegate: ItemsListDelegate?

    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.redButton.center = CGPoint(x: self.redButton.center.x - 100, y: self.redButton.center.y)
            self.greenButton.center = CGPoint(x: self.greenButton.center.x + 100, y: self.greenButton.center.y)
            self.blueButton.center = CGPoint(x: self.blueButton.center.x - 100, y: self.blueButton.center.y)
        }) { (finished) in
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.redButton.center = CGPoint(x: self.redButton.center.x + 100, y: self.redButton.center.y)
                self.greenButton.center = CGPoint(x: self.greenButton.center.x - 100, y: self.greenButton.center.y)
                self.blueButton.center = CGPoint(x: self.blueButton.center.x + 100, y: self.blueButton.center.y)
            })
        }
    }
    
    @IBAction func generateRed(_ sender: Any) {
        generate(color: UIColor.red, from: 1, to: 10)
    }
    
    @IBAction func generateGreen(_ sender: Any) {
        generate(color: UIColor.green, from: 1, to: 50)
    }
    
    @IBAction func generateBlue(_ sender: Any) {
        generate(color: UIColor.blue, from: 11, to: 49)
    }
    
    private func generate(color: UIColor, from: Int, to: Int) {
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.color = color
        activityIndicatorView.backgroundColor = UIColor.white
        activityIndicatorView.startAnimating()
        
        requestNumber(from: from, to: to, color: color)
    }
    
    private func requestNumber(from: Int, to: Int, color: UIColor) {
        let requestString: String = "https://www.random.org/integers/?num=1&min=" + String(from) + "&max=" + String(to) + "&base=10&format=plain&col=1"
        
        AF.request(requestString).responseString { response in
            switch response.result {
            case .success(_):
                if
                    let responseNumber = response.value
                {
                    let numberItem = NumberItem(number: responseNumber, color: color)
                    self.itemsListDelegate?.add(item: numberItem)
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
