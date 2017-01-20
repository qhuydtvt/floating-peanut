//
//  EnemyController.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class EnemyController : Controller {
    var sprite : SKSpriteNode
    
    init() {
        sprite = SKSpriteNode(imageNamed: "rock")
    }
    
    func config(parent: SKNode) {
        
    }
    
    func run(parent: SKNode, time: TimeInterval) {
        
    }
}
