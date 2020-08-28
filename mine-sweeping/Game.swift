//
//  Game.swift
//  mine-sweeping
//
//  Created by mac on 2020/8/20.
//  Copyright © 2020 rain. All rights reserved.
//

import Foundation

enum GameStatus{
    case running
    case lost
    case win
}

struct Game {
    var board: Array<Array<Card>> = []
    var size:Int
    var status:GameStatus
    
    var score:Int = 0
    
    var bonus:Int = 1
    
    init(size:Int) {
        self.status = .running
        self.size = size
        for _ in 0..<size {
            let minesNum = Int.random(in: 0..<Int(size/2))
            var mineIndexSet = Set<Int>()
            while mineIndexSet.count < minesNum {
                mineIndexSet.insert(Int.random(in: 0..<size))
            }
            var arr:Array<Card> = []
            for j in 0..<size{
                if(mineIndexSet.contains(j)){
                    arr.append(Card("M"))
                }else{
                    arr.append(Card("E"))
                }
            }
            board.append(arr)
        }
    }
    
    init(size:Int, score:Int) {
        self.init(size: size)
        self.score = score
    }
    
    mutating func longPress(x:Int,y:Int){
        if(board[y][x].value == "M" || board[y][x].value == "E"){
            board[y][x].isFlagged = !board[y][x].isFlagged
        }
    }
    
    mutating func tap(x:Int,y:Int){
        if(x < 0 || x >= board[0].count || y < 0 || y >= board.count){
            return
        }
        if(board[y][x].value == "M"){
            board[y][x].value = "X"
            status = .lost
            return
        }
        if(board[y][x].value == "E"){
            let num = findMineNum(x: x, y: y)
            if(num == 0){
                board[y][x].value = "B"
                score += bonus
                for i in y-1...y+1{
                    for j in x-1...x+1{
                        tap(x: j, y: i)
                    }
                }
                
            }else{
                board[y][x].value = String(num)
                score += bonus
            }
        }
        if(isWin()){
            status = .win
        }
    }
    
    func findMineNum(x:Int,y:Int) -> Int{
        if(!isWithinBoard(x: x, y: y)){
            return 0
        }
        var res = 0
        for i in y-1...y+1{
            for j in x-1...x+1{
                if(isMine(x: j, y: i)){
                    res += 1
                }
            }
        }
        return res
    }
    
    func isWithinBoard(x:Int,y:Int) -> Bool {
        if(x < 0 || x >= board[0].count || y < 0 || y >= board.count){
            return false
        }else{
            return true
        }
    }
    
    func isMine(x:Int,y:Int) -> Bool {
        if(isWithinBoard(x: x, y: y)){
            return board[y][x].value == "M"
        }else{
            return false
        }
    }
    
    func isWin() -> Bool {
        var res = true
        for i in 0..<size {
            for j in 0..<size {
                if(board[i][j].value == "E"){
                    res = false
                }
            }
        }
        return res
    }
    
}
