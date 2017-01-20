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
    
    override init() {
        sprite = SKSpriteNode(imageNamed: "rock")
    }
    
    override func config(parent: SKNode) {
        
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        
    }
}
