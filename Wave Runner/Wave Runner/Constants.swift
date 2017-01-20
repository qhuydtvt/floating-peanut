//
//  Constants.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

struct Masks {
    static let PLAYER          =   UInt32(1 << 0)
    static let PLAYER_WAVE     =   UInt32(1 << 1)
    
    static let ENEMY           =   UInt32(1 << 2)
    static let ENEMY_WAVE      =   UInt32(1 << 3)
    
    static let PLATFORM        =   UInt32(1 << 4)
}


struct Speed {
    static let PLATFORM_SPEED : CGFloat = 5
    static let ENEMY_VELOCITY : CGFloat = PLATFORM_SPEED * 60
}
