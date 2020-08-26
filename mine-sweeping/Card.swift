//
//  Card.swift
//  mine-sweeping
//
//  Created by mac on 2020/8/26.
//  Copyright © 2020 rain. All rights reserved.
//

import Foundation

struct Card {
    var value:String;
    var isFlagged:Bool = false;
    
    var displayText:  String {
        get{
            switch value {
            case "X":
                return "💣"
            case "E","B","M":
                return ""
            default:
                return value
            }
        }
    }
    
    var isFaceDown: Bool{
        get{
            if(value == "E" || value == "M"){
                return true
            }else{
                return false
            }
        }
    }
    
    init(_ value:String) {
        self.value = value
    }
    
}
