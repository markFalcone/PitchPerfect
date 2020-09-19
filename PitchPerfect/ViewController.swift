//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Mark Falcone on 9/18/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func recordAudio(_ sender: UIButton) {
        print (sender.currentTitle)
        if sender.currentTitle == "Start"{
            sender.setTitle("Stop", for: .normal)
            recordingLabel.text = "RECORDING"
            print("in f")
        } else {
            sender.setTitle("Start", for: .normal)
            recordingLabel.text = "Tap to Record"
            print("in 2")
        }
        
    }
    

}

