//
//  ViewController.swift
//  Timer
//
//  Created by aluno on 29/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TimerLabel : UILabel!
    @IBOutlet weak var startStopButton : UIButton!
    @IBOutlet weak var resetButton : UIButton!
    
    var timer : Timer = Timer()
    var count : Int = 0
    var timerCounting : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopButton.setTitleColor(UIColor.blue, for: .normal)
        print("Começou")
    }
    @IBAction func resetTapped(_ sender : Any){
        let alert = UIAlertController(title: "Reiniciar?", message : "Tem certeza?", preferredStyle : .alert)
        alert.addAction(UIAlertAction(title: "CANCELAR", style: .cancel, handler: {(_) in
            // faz nada
        }))
        alert.addAction(UIAlertAction(title: "SIM", style: .default, handler: {(_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("INICIAR", for: .normal)
            self.startStopButton.setTitleColor(UIColor.blue, for: .normal)

        }))
        self.present(alert, animated : true, completion: nil)
    }
    @IBAction func startStopTapped(_ sender : Any){
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("INICIAR", for: .normal)
            startStopButton.setTitleColor(UIColor.blue, for: .normal)
        } else {
            timerCounting = true
            startStopButton.setTitle("PARAR", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void {
        print("Sim")
        count = count + 1
        let time = secondsToHoursMinutesSeconds(secondes: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(secondes : Int) -> (Int, Int, Int){
        return (secondes / 3600, (secondes % 3600) / 60, ((secondes % 3600) % 60) / 60)
    }
    
    func makeTimeString(hours : Int, minutes : Int, seconds : Int) -> String{
        var timeString = ""
        timeString += String(format:"%02d", hours)
        timeString += " : "
        timeString += String(format:"%02d", minutes)
        timeString += " : "
        timeString += String(format:"%02d", seconds)
        return timeString

    }
}

