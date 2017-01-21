//
//  SonicWallController.swift
//  Wave Runner
//
//  Created by Apple on 1/22/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class SonicWallController : SingleControler {
    init() {
        super.init(view: View(texture: Textures.sonic_wall))
    }
    
    //var cropNode : SKCropNode!
    //var sonicWall : SKSpriteNode!
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        
        self.view.anchorPoint = CGPoint(x: 0.5, y: 0)
        
//        self.sonicWall = SKSpriteNode(texture: Textures.sonic_wall)
//        
//        self.cropNode = SKCropNode()
//        self.cropNode.maskNode = SKSpriteNode(texture: Textures.sonic_wall)
//        self.cropNode.addChild(self.sonicWall)
        
        
        self.view.zPosition = 200
        
        self.view.xScale = 0.5
        self.view.run(.scaleX(to: 1, duration: 0.5))
        
//        self.view.run(.sequence([
//            .wait(forDuration: 2),
//            .removeFromParent()
//            ]))
        
        configPhysics()
    }
    
    func configPhysics() -> Void {
        self.view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.categoryBitMask = Masks.ENEMY_SONIC
        self.view.physicsBody?.contactTestBitMask = Masks.PLAYER_SONIC
        
        self.view.handleContact = { [unowned view = self.view] 
            other in
            print("XXX")
            other.destroy?()
            view.contacted = false
        }
    }
}
