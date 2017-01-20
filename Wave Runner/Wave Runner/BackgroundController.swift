//
//  BackgroundController.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class BackgroundController {
    var background1: SKSpriteNode!
    var background2: SKSpriteNode!
    
    init() {
        background1 = SKSpriteNode(imageNamed: "background")
        background2 = SKSpriteNode(imageNamed: "background")
        
        background1.name = "background"
        background2.name = "background"
        
        background1.anchorPoint = .zero
        background2.anchorPoint = .zero
    }
    
    func config(parent: SKNode) -> Void {
        background1.position = .zero
        background2.position = CGPoint(x: background1.position.x + background1.size.width - 5, y: background2.position.y)
        
        parent.addChild(background1)
        parent.addChild(background2)
    }
    
    func run(parent: SKNode) -> Void {
        parent.enumerateChildNodes(withName: "background", using: {
            node, _ in
            let background = node as! SKSpriteNode
            background.position = background.position.add(x: -2, y: 0)
            if background.position.x <  -background.size.width {
                background.position = CGPoint(x: background.position.x + background.size.width * 2 - 10, y: background.position.y)
            }
        })
    }
}
