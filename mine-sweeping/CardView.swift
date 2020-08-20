//
//  CardView.swift
//  mine-sweeping
//
//  Created by mac on 2020/8/20.
//  Copyright © 2020 rain. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var value = ""
    
    var body: some View {
        GeometryReader{ geo in
            self.body(for: geo.size)
        }
    }
    
    @ViewBuilder
    private func body(for size:CGSize) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius:10).fill(isFaceDown(value: value) ? Color.orange : Color.gray)
            Text(displayText(with: value)).font(Font.system(size: size.width * 0.5))
        }
    }
    
    private func displayText(with value:String) -> String {
        switch value {
        case "X":
            return "💣"
        case "E","B","M":
            return ""
        default:
            return value
        }
    }
    
    
    private func isFaceDown (value:String) -> Bool {
        if(value == "E" || value == "M"){
            return true
        }else{
            return false
        }
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
