//
//  PlayerController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerController: Controller {
    var container: SKNode!
    var player: View!
    var board: SKSpriteNode!
    
    var attackAnimation = SKTextureAtlas(named: "goku_attack").toTextures()
    
    override init() {
        self.player = View(image: #imageLiteral(resourceName: "goku_standing"))
        self.board = SKSpriteNode(image: #imageLiteral(resourceName: "hover_board"))
        self.container = SKNode()
        
        container.addChild(player)
        container.addChild(board)
        container.setScale(3)
        container.zPosition = 3
        
        player.position = CGPoint(x: 10.05, y: 24.5)
        
//        player.physicsBody = SKPhysicsBody(rectangleOf: player.frame.size)
        player.physicsBody?.categoryBitMask = Masks.PLAYER
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        container.position = position
        parent.addChild(container)
    }
    
    func attack() {
        var anim = attackAnimation
        anim.append(player.texture!)
        self.player.run(.animate(with: anim, timePerFrame: 0.15, resize: true, restore: true))
    }
}
