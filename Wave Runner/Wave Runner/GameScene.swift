//
//  GameScene.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/20/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var background1: SKSpriteNode!
    var background2: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        background1 = SKSpriteNode(imageNamed: "background")
        background2 = SKSpriteNode(imageNamed: "background")
        
        background1.name = "background"
        background2.name = "background"
        
        background1.anchorPoint = .zero
        background2.anchorPoint = .zero
        
        background2.position = CGPoint(x: background1.position.x + background1.size.width, y: background2.position.y)
        
        
        self.addChild(background1)
        self.addChild(background2)
    }
    
    override func update(_ currentTime: TimeInterval) {
        enumerateChildNodes(withName: "background", using: {
            node, _ in
            let background = node as! SKSpriteNode
            background.position = background.position.add(x: -2, y: 0)
            if background.position.x <  -background.size.width {
                background.position = CGPoint(x: background.position.x + background.size.width * 2 , y: background.position.y)
            }
        })
    }
}
