//
//  PlatformController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//
import SpriteKit
import Foundation

class PlatformController: Controller {
    var platform1: View!
    var platform2: View!
    
    override init() {
        platform1 = View(image: #imageLiteral(resourceName: "platform"))
        platform2 = View(image: #imageLiteral(resourceName: "platform"))
        
        
        platform1.name = "platform"
        platform2.name = "platform"

        platform1.zPosition = 2
        platform2.zPosition = 2
    }
    
    override func config(position: CGPoint, parent: SKNode) -> Void {
        platform1.size.height = parent.frame.height / 3
        platform2.size.height = parent.frame.height / 3
        
        platform1.physicsBody = SKPhysicsBody(rectangleOf: platform1.size)
        platform1.physicsBody?.affectedByGravity = false
        platform1.physicsBody?.categoryBitMask = Masks.PLATFORM
        
        platform2.physicsBody = SKPhysicsBody(rectangleOf: platform2.size)
        platform2.physicsBody?.affectedByGravity = false
        platform2.physicsBody?.categoryBitMask = Masks.PLATFORM
        
        platform1.position = CGPoint(x: platform1.width / 2, y: platform2.height / 2)
        platform2.position = CGPoint(x: platform1.position.x + platform1.size.width - 5, y: platform1.position.y)
        
        parent.addChild(platform1)
        parent.addChild(platform2)
    }
    
    func run(parent: SKNode) -> Void {
        parent.enumerateChildNodes(withName: "platform", using: {
            node, _ in
            let background = node as! SKSpriteNode
            background.position = background.position.add(dx: -Speed.PLATFORM_SPEED, dy: 0)
            if background.position.x <  -background.size.width / 2 {
                background.position = CGPoint(x: background.position.x + background.size.width * 2 - 2*Speed.PLATFORM_SPEED, y: background.position.y)
            }
        })
    }
}
