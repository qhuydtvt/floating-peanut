//
//  HelpViewController.swift
//  Wave Runner
//
//  Created by Vũ Kiên on 22/01/2017.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

var helps = [[#imageLiteral(resourceName: "help1"), #imageLiteral(resourceName: "laser")], [#imageLiteral(resourceName: "help2"), #imageLiteral(resourceName: "help8")], [#imageLiteral(resourceName: "help3"), #imageLiteral(resourceName: "help9")], [#imageLiteral(resourceName: "help4"), #imageLiteral(resourceName: "help6")], [#imageLiteral(resourceName: "help5"), #imageLiteral(resourceName: "arc_right")]]

class HelpViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissHelp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HelpViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let image1 = cell.contentView.viewWithTag(101) as! UIImageView
        let image2 = cell.contentView.viewWithTag(102) as! UIImageView
        let help = helps[indexPath.row]
        image1.image = help[0]
        image2.image = help[1]
        image1.layer.masksToBounds = true
        image2.layer.masksToBounds = true
        return cell
    }
}

extension HelpViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width/3.0, height: self.collectionView.frame.height / 2.0)
    }
}

