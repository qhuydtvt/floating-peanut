//
//  PlatformController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//
import SpriteKit
import Foundation

class PlatformController {
    var platform1: SKSpriteNode!
    var platform2: SKSpriteNode!
    
    init() {
        platform1 = SKSpriteNode(image: #imageLiteral(resourceName: "platform"))
        platform2 = SKSpriteNode(image: #imageLiteral(resourceName: "platform"))
        
        platform1.name = "platform"
        platform2.name = "platform"
        
        platform1.anchorPoint = .zero
        platform2.anchorPoint = .zero

        platform1.zPosition = 2
        platform2.zPosition = 2
    }
    
    func config(parent: SKNode) -> Void {
        platform1.position = .zero
        platform2.position = CGPoint(x: platform1.position.x + platform1.size.width - 5, y: platform2.position.y)
        
        parent.addChild(platform1)
        parent.addChild(platform2)
    }
    
    func run(parent: SKNode) -> Void {
        parent.enumerateChildNodes(withName: "platform", using: {
            node, _ in
            let background = node as! SKSpriteNode
            background.position = background.position.add(x: -5, y: 0)
            if background.position.x <  -background.size.width {
                background.position = CGPoint(x: background.position.x + background.size.width * 2 - 10, y: background.position.y)
            }
        })
    }
}
