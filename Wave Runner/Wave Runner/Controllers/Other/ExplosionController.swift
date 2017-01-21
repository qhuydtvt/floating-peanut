//
//  ExplosionController.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class ExplosionController: Controller {
    var explosionNode : SKEmitterNode!
    init(fileName: String) {
        super.init()
        explosionNode = SKEmitterNode(fileNamed: fileName)!
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        explosionNode.position = position
        parent.addChild(explosionNode)
        explosionNode.run(.sequence([
            .wait(forDuration: 1),
            .removeFromParent()
            ]))
    }
}
