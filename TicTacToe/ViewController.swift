//
//  ViewController.swift
//  TicTacToe
//
//  Created by Ümit Şimşek on 13.03.2023.
//

import UIKit

class ViewController: UIViewController {
    enum Turn {
        case Nought
        case Cross
    }

    @IBOutlet weak var lblTurn: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var currentTurn = Turn.Cross
    var firstTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    
    var noughtScore = 0
    var crossScore = 0
    
    var board = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
        
    }
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if fullBoard() {
            resultAlert(title: "Draw")
        }
        
        if checkForVictory(s: CROSS){
            crossScore += 1
            resultAlert(title: "Crosses Win!")
        }
        if checkForVictory(s: NOUGHT){
            noughtScore += 1
            resultAlert(title: "Noughts Win!")
            
        }
    }
    
    func initBoard(){
        board.append(a1)
        board.append(a2)
        board.append(a3)
        
        board.append(b1)
        board.append(b2)
        board.append(b3)
        
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    func checkForVictory(s: String) -> Bool {
        //Horizontal Victory
        if thisSymbol(button: a1, symbol: s) && thisSymbol(button: a2, symbol: s) && thisSymbol(button: a3, symbol: s){
            return true
        }
        if thisSymbol(button: b1, symbol: s) && thisSymbol(button: b2, symbol: s) && thisSymbol(button: b3, symbol: s){
            return true
        }
        if thisSymbol(button: c1, symbol: s) && thisSymbol(button: c2, symbol: s) && thisSymbol(button: c3, symbol: s){
            return true
        }
        
        //Vertical Victory
        if thisSymbol(button: a1, symbol: s) && thisSymbol(button: b1, symbol: s) && thisSymbol(button: c1, symbol: s){
            return true
        }
        if thisSymbol(button: a2, symbol: s) && thisSymbol(button: b2, symbol: s) && thisSymbol(button: c2, symbol: s){
            return true
        }
        if thisSymbol(button: a3, symbol: s) && thisSymbol(button: b3, symbol: s) && thisSymbol(button: c3, symbol: s){
            return true
        }
        
        //Diagonal Victory
        if thisSymbol(button: a1, symbol: s) && thisSymbol(button: b2, symbol: s) && thisSymbol(button: c3, symbol: s){
            return true
        }
        if thisSymbol(button: a3, symbol: s) && thisSymbol(button: b2, symbol: s) && thisSymbol(button: c1, symbol: s){
            return true
        }
        return false
    }
    
    func thisSymbol(button : UIButton, symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil{
                return false
            }
        }
        return true
    }
    
    func resultAlert(title: String) {
        let message = "\nNoughts " + String(noughtScore) + "\n\nCrosses " + String(crossScore)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Reset", style: UIAlertAction.Style.default, handler: { action in
            self.resetBoard()
        }))
        self.present(alert, animated: true)
    }
    
    func resetBoard(){
        
        for button in board{
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            lblTurn.text = CROSS
        }else if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            lblTurn.text = NOUGHT
        }
        currentTurn = firstTurn

        
    }
    func addToBoard(_ sender: UIButton){
        if sender.title(for: .normal) == nil {
            if currentTurn == Turn.Cross {
                sender.setTitle(CROSS, for: UIControl.State.normal)
                currentTurn = Turn.Nought
                lblTurn.text = NOUGHT
            }else if currentTurn == Turn.Nought {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                lblTurn.text = CROSS
            }
            sender.isEnabled = false
        }
    }

}

