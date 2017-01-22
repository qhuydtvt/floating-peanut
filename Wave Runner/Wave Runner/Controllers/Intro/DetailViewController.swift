//
//  DetailViewController.swift
//  Wave Runner
//
//  Created by Vũ Kiên on 21/01/2017.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    fileprivate let transition = TransitionAnimation()
    
    var image: UIImage?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.playButton.isHidden = true
        self.helpButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if index == images.count - 1 {
            self.playButton.isHidden = false
            self.helpButton.isHidden = false
        } else {
            self.playButton.isHidden = true
            self.helpButton.isHidden = true
        }
        self.imageView.image = image
        print(index)
    }
    
    @IBAction func playDidTapped(_ sender: UIButton) {
        print("Play")
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "playGame" {
            let vc = segue.destination as! GameViewController
            vc.transitioningDelegate = self
        }
    }
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return transition
//    }
}
