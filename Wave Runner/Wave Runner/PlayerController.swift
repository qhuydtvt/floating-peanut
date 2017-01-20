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
    var player: View!
    
    override init() {
        
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        player.position = position
        player.physicsBody = SKPhysicsBody()
        player.physicsBody?.categoryBitMask = Masks.PLAYER
        parent.addChild(player)
    }
    
    
}
