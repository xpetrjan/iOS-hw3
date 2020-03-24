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
    private var numberColor: UIColor = UIColor.init()
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    private(set) var generatedNumber: String? {
        didSet {
            let numberItem = NumberItem(number: generatedNumber!, color: numberColor)
            itemsListDelegate?.add(item: numberItem)
            dismiss(animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.redButton.center = CGPoint(x: self.redButton.center.x - 100, y: self.redButton.center.y)
            self.greenButton.center = CGPoint(x: self.greenButton.center.x + 100, y: self.greenButton.center.y)
            self.blueButton.center = CGPoint(x: self.blueButton.center.x - 100, y: self.blueButton.center.y)
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
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
        numberColor = color
        requestNumber(from: from, to: to)
        
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.color = color
        activityIndicatorView.backgroundColor = UIColor.white
        activityIndicatorView.startAnimating()
    }
    
    private func requestNumber(from: Int, to: Int) {
        let requestString: String = "https://www.random.org/integers/?num=1&min=" + String(from) + "&max=" + String(to) + "&base=10&format=plain&col=1"
        
        AF.request(requestString).responseString { response in
            switch response.result {
            case .success(_):
                if
                    let responseNumber = response.value
                {
                    self.generatedNumber = responseNumber
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
