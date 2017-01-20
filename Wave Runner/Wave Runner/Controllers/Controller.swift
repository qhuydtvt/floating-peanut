//
//  Controller.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class Controller {
    
    var position: CGPoint
    weak var parent: SKNode!
    var children : [Controller] = []
    
    init() {
        self.position = .zero
    }
    
    
    func config(position: CGPoint, parent: SKNode) -> Void {
        self.position = position
        self.parent = parent
    }
    
    func run(parent: SKNode, time: TimeInterval) -> Void {
        
    }
    
    func destroy() -> Void {
        for child in self.children {
            child.destroy()
        }
        self.children.removeAll()
    }
}
