//
//  View.swift
//  Galaga
//
//  Created by Apple on 11/11/16.
//  Copyright © 2016 TechKids. All rights reserved.
//

import SpriteKit

typealias HandleContactType = ((View) -> Void)
typealias DestroyType = (() -> Void)

class View : SKSpriteNode {
    
    var handleContact : HandleContactType?
    var destroy: DestroyType?
    var contacted = false
    var avoidContact = false
    
    weak var controller: Controller?
    weak var physicsWorld: SKPhysicsWorld?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    func move(vector: CGVector) {
        self.position = self.position.add(vector: vector)
    }
}
