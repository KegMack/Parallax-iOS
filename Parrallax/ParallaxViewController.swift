//
//  ParallaxViewController.swift
//  Parrallax
//
//  Created by Craig Chaillie on 10/1/19.
//  Copyright © 2019 Craig Chaillie. All rights reserved.
//

//MIT License
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.



import UIKit


class ParallaxViewController: UIViewController, UIScrollViewDelegate {

    private var parallaxView: UIImageView?
    private var parallaxImage: UIImage?
    private var scrollView: UIScrollView?
    private var contentViewController: UIViewController?
    
    private var parallaxInitialCenterY: CGFloat = 0


    /**
     Ratio of vertical size of background image to content view
     For very long content views, higher number is recommended
     Must be greater than 1.0, or setter will be ignored.
     Defaults to 1.4
     */
    private var parallaxScrollRatio: Double  = 1.4 {
        didSet(newValue) {
            guard newValue > 1.0 else {
                return
            }
            parallaxScrollRatio = newValue
            
        }
    }

    private static let kDefaultParallaxScrollRatio: Double = 1.4
    
    
    //MARK: Initializers
    
    /**
     Creates a parallax view controller.
     - Parameters:
      -parallaxRatio: The ratio of screen height to total background image height.  Affects the rate of scrolling of parallax image.  Recommend between 1.0 and 3.0.  Defaults to 1.4
     - image: The background image which will be scrolled parallax style.
     - contentViewController: The view controller which would be displayed in front of parallax image and placed in a scrollView.  Recommended clear or semi-opaque background.
    */
    init(parallaxRatio: Double = ParallaxViewController.kDefaultParallaxScrollRatio, image: UIImage, contentViewController: UIViewController) {
        self.parallaxImage = image
        self.parallaxScrollRatio = parallaxRatio
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeParallaxView()
        initializeScrollView()
        initializeContentView()
    }

    
    //MARK: Initialization/Configuration
    
    private func initializeParallaxView() {
        let frame = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.width, height: view.bounds.height * CGFloat(parallaxScrollRatio))
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.image = parallaxImage
        parallaxInitialCenterY = imageView.center.y
        parallaxView = imageView
        view.addSubview(imageView)
    }
    
    private func initializeScrollView() {
        let scrollView = UIScrollView(frame: view.frame)
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.clear
        guard let pView = parallaxView else {
            return
        }
        self.scrollView = scrollView
        view.insertSubview(scrollView, aboveSubview: pView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true;
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true;
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true;

    }
    
    private func initializeContentView() {
        guard let contentVC = contentViewController,
            let scrollView = self.scrollView else {
            return
        }
        addChild(contentVC)
        scrollView.addSubview(contentVC.view)
        contentVC.view.translatesAutoresizingMaskIntoConstraints = false
        contentVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true;
        contentVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true;
        contentVC.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true;
        contentVC.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true;
        contentVC.view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
    }
    

    
    //MARK: UIScrollView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
        moveParallax(inScrollView: scrollView)
    }
    
    
    //MARK: Parallax movement/scrolling
    
    private func moveParallax(inScrollView scrollView: UIScrollView) {
        guard let parallax = parallaxView,
            parallax.bounds.height > 0,
            scrollView.contentSize.height > 0 else {
                return
        }
        let maxOffset = parallax.bounds.height - scrollView.bounds.height
        let adjustedScrollOffset = scrollView.contentOffset.y + scrollView.bounds.height
        parallax.center.y = parallaxInitialCenterY - scrollView.contentOffset.y / adjustedScrollOffset * maxOffset

    }
}

