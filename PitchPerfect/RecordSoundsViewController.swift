//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Mark Falcone on 9/18/20.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var save: UIButton!
    @IBOutlet var saveLabel: UILabel!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        save.isEnabled = false
        saveLabel.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
   
    @IBAction func recordAudio(_ sender: UIButton) {
        
    
        if sender.currentTitle == "Start"{
            // change the buttons and labels
            sender.setTitle("Stop", for: .normal)
            sender.setImage(UIImage(named: "Stop.png"), for: .normal)
            recordingLabel.text = "RECORDING"
            save.isEnabled = false
            saveLabel.isEnabled = false
            //start recording
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
                let recordingName = "recordedVoice.wav"
                let pathArray = [dirPath, recordingName]
                let filePath = URL(string: pathArray.joined(separator: "/"))

                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

                try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
                audioRecorder.record()
            print(filePath)
            
        } else {
            // change buttons and labels
            sender.setTitle("Start", for: .normal)
            sender.setImage(UIImage(named: "Record.png"), for: .normal)
            recordingLabel.text = "Tap to Record"
            save.isEnabled = true
            saveLabel.isEnabled = true
            // stop recording
            audioRecorder.pause()
            
        }
        
    }
    @IBAction func SavePressed(_ sender: Any) {
        print("Save pressed")
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("recording finished ")
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("recording was not successfull")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURl = recordedAudioURL
            
        }
    }
    
    

}

