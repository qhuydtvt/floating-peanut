//
//  EnemyController.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class EnemyController : Controller {
    var view: View!
    
    override init() {
        view = View(image: #imageLiteral(resourceName: "rock"))
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        view.position = position
        parent.addChild(view)
        view.run(.moveTo(x: 0, duration: 1))
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        
    }
}
