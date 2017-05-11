//
//  ViewController.swift
//  ScrollViews
//
//  Created by Lane Faison on 5/10/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var images = [UIImageView]() // initializes an empty array of images
    let MAX_PAGE = 2
    let MIN_PAGE = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let scrollWidth = scrollView.frame.size.width
        let scrollHeight = scrollView.frame.size.height
        
        var contentWidth: CGFloat = 0.0
        
        for x in 0...2 {
            let image = UIImage(named: "icon\(x).png")
            let imageView = (UIImageView(image: image))
            images.append(imageView)
            
            var newX: CGFloat = 0.0
            newX = scrollWidth/2 + scrollWidth * CGFloat(x)
            
            contentWidth += newX
            
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: newX-75, y: (scrollHeight / 2)-75, width: 150, height: 150)
        }
        
        self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
        
        scrollView.clipsToBounds = false // This shows the next item coming in on scroll
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
        
    }
    
    @IBAction func detectSwipe(_ sender: UISwipeGestureRecognizer) {
        if (currentPage < MAX_PAGE && sender.direction == UISwipeGestureRecognizerDirection.left) {
            moveScrollView(direction: 1)
        }
        
        if (currentPage > MIN_PAGE && sender.direction == UISwipeGestureRecognizerDirection.right) {
            moveScrollView(direction: -1)
        }
    }
    
    func moveScrollView(direction: Int) {
        currentPage = currentPage + direction
        let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(point, animated: true)
        
        // Create an animation to increase the actual icon on the screen
        UIView.animate(withDuration: 0.4){
            self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
            
            // Revert icon size of the non-active pages
            for x in 0..<self.images.count {
                if (x != self.currentPage) {
                    self.images[x].transform = CGAffineTransform.identity
                }
            }
        }
    }

    


}

