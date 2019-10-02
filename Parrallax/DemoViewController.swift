//
//  DemoViewController.swift
//  Parrallax
//
//  Created by Craig Chaillie on 10/1/19.
//  Copyright © 2019 Craig Chaillie. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func shortTapped(_ sender: UIButton) {
        guard let image = UIImage(named: "BG1") else {
            print("unable to obtain image")
            return
        }
        let longTextVC = LongTextViewController()
        let parallaxVC = ParallaxViewController(parallaxRatio: 1.3, image: image, contentViewController: longTextVC)
        navigationController?.pushViewController(parallaxVC, animated: true)

    }
    
    @IBAction func longTapped(_ sender: Any) {
        guard let image = UIImage(named: "BG1") else {
            print("unable to obtain image")
            return
        }
        let longTextVC = LongTextViewController()
        let parallaxVC = ParallaxViewController(parallaxRatio: 2.3, image: image, contentViewController: longTextVC)
        navigationController?.pushViewController(parallaxVC, animated: true)
    }
    
    
   

}
