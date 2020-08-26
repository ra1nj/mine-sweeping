//
//  GameViewModel.swift
//  mine-sweeping
//
//  Created by mac on 2020/8/20.
//  Copyright © 2020 rain. All rights reserved.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published private(set) var model: Game = GameViewModel.createGame()
    
    private static var level = 3
    
    private static func createGame () -> Game {
        return Game(size: GameViewModel.level)
    }
    
    //MARK: - Access to the model
    var board:Array<Array<Card>>{
        model.board
    }
    
    var size:Int {
        model.size
    }
    
    var status:GameStatus{
        model.status
    }
    
    var score:Int {
        model.score
    }
    
    //MARK: - Intent(s)
    func tap(x:Int, y:Int) {
        model.tap(x: x,y: y)
    }
    
    func longPress(x:Int,y:Int){
        model.longPress(x:x,y:y)
    }
    
    func newGame(){
        model = GameViewModel.createGame()
    }
    
    func nextLevel(){
        GameViewModel.level += 1
        model = Game(size: GameViewModel.level, score: score)
    }
}
