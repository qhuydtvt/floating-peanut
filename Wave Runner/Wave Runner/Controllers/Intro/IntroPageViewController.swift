//
//  IntroPageViewController.swift
//  Wave Runner
//
//  Created by Vũ Kiên on 21/01/2017.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

var images = [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image4"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image7"), #imageLiteral(resourceName: "image8"), #imageLiteral(resourceName: "image9"), #imageLiteral(resourceName: "MainPlay")]

class IntroPageViewController: UIPageViewController {
    
    var currentIndex: Int = 0

    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setViewControllers([self.viewController(index: 0)!], direction: .forward, animated: true, completion: nil)
        UserDefaults.standard.set(1, forKey: "OPEN")
        self.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    fileprivate func viewController(index: Int) -> DetailViewController? {
        if images.count < 0 || index >= images.count {
            return nil
        }
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        detailVC?.image = images[index]
        detailVC?.index = index
        self.currentIndex = index
        
        return detailVC
    }

}

extension IntroPageViewController: UIPageViewControllerDataSource {

//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return images.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as? DetailViewController)?.index, index > 0 else {
            return nil
        }
        index -= 1
        return self.viewController(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = (viewController as? DetailViewController)?.index else {
            return nil
        }
        
        guard index + 1 < images.count else {
            return nil
        }
        
        return self.viewController(index: index + 1)
    }
    
    
}
