//
//  CardView.swift
//  mine-sweeping
//
//  Created by mac on 2020/8/20.
//  Copyright © 2020 rain. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var card:Card
    
    var body: some View {
        GeometryReader{ geo in
            self.body(for: geo.size)
        }
    }
    
    @ViewBuilder
    private func body(for size:CGSize) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius:10).fill(card.isFaceDown ? Color.orange : Color.gray)
                .rotation3DEffect(.init(degrees:card.isFaceDown ? 0 : 180), axis: (x:0,y:1,z:0))
            Text(card.displayText).font(Font.system(size: size.width * 0.5))
        }
        .transition(.slide).animation(.easeInOut)
    }
    
//    private func displayText() -> String {
//        switch value {
//        case "X":
//            return "💣"
//        case "E","B","M":
//            return ""
//        default:
//            return value
//        }
//    }
    
    
//    private func isFaceDown () -> Bool {
//        if(value == "E" || value == "M"){
//            return true
//        }else{
//            return false
//        }
//    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card("M"))
    }
}
