//
//  GameView.swift
//  mine-sweeping
//
//  Created by mac on 2020/8/20.
//  Copyright © 2020 rain. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel:GameViewModel
    
   
    
    var body: some View {
        ZStack{
            VStack{
                ForEach(0..<viewModel.size,id:\.self) {i in
                    HStack{
                        ForEach(0..<self.viewModel.size,id:\.self) {j in
                            CardView(card:  self.viewModel.board[i][j])
                                .gesture(TapGesture().onEnded{_ in
                                    if(self.viewModel.status == GameStatus.running){
                                        self.viewModel.tap(x: j, y: i)
                                    }
                                })
                        }
                        
                    }
                }
            }
//            renderLost()
            renderGameStatus()
        }.padding()
    }
    
    @ViewBuilder
    func renderGameStatus() -> some View {
        if(viewModel.status == .lost){
            renderLost()
        }else if(viewModel.status == .win){
            renderWin()
        }
    }
    
    func renderLost() -> some View {
        VStack{
            Text("Bang💥 You lost! wanna try again?")
            renderNewGame()
        }
        .toastStyle()
    }
    
    func renderWin() -> some View {
        VStack{
            Text("Congratulations🥳 You win! wanna try next level or try this level again?")
            HStack{
                renderNewGame()
                renderNextLevel()
            }
        }
    .toastStyle()
    }
    
    func renderNewGame() -> some View {
        Button("new game"){
            self.viewModel.newGame()
        }
    }
    
    func renderNextLevel() -> some View {
        Button("next level"){
            self.viewModel.nextLevel()
        }
    }
    
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}

struct TipToast: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .transition(.offset(x: 0, y: 300))
            .animation(.easeInOut)
    }
}

extension View {
    func toastStyle() -> some View {
        self.modifier(TipToast())
    }
}
