//
//  DVRViewController.swift
//  DPara_Remote
//
//  Created by David Para on 2/16/17.
//  Copyright © 2017 David Para. All rights reserved.
//

import UIKit

class DVRViewController: UIViewController {
    
    enum State: String {
        case Stopped        = "Stopped"
        case Playing        = "Playing"
        case Paused         = "Paused"
        case Recording      = "Recording"
        case FRewinding     = "FRewinding"
        case Fforwading     = "FForwarding"
        case ForcedAction   = ""
        var name: String { return self.rawValue }
    }
    
    var currentState: State = State.Stopped;
    var powerLeftOn: Bool = false;
    
    @IBOutlet weak var onOffLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var powerSwitch: UISwitch!
    @IBOutlet var stateButtons: [UIButton]!
    
    @IBAction func PowerSwitched(_ sender: UISwitch) {
        
        
        let onOrOff = (sender.isOn == true)
        powerRemote(on: onOrOff)
    }
    
    @IBAction func stateButtonsPressed(_ sender: UIButton) {
        if let desiredState = sender.currentTitle {
            
            // Action was forced
            if currentState == State.ForcedAction {
                switch desiredState {
                case "pause":
                    updateState(state: State.Paused)
                case "fast rewind":
                    updateState(state: State.FRewinding)
                case "fast forward":
                    updateState(state: State.Fforwading)
                case "stop":
                    updateState(state: State.Stopped)
                case "play":
                    updateState(state: State.Playing)
                case "record":
                    updateState(state: State.Recording)
                default:
                    break
                }
            // Playing
            } else if currentState == State.Playing {
                switch desiredState {
                case "pause":
                    updateState(state: State.Paused)
                case "fast rewind":
                    updateState(state: State.FRewinding)
                case "fast forward":
                    updateState(state: State.Fforwading)
                case "stop":
                    updateState(state: State.Stopped)
                case "play":
                    break
                default:
                    actionSheetPopup(sender)
                }
            // Stopped
            } else if currentState == State.Stopped {
                switch desiredState {
                case "play":
                    updateState(state: State.Playing)
                case "record":
                    updateState(state: State.Recording)
                case "stop":
                    break
                default:
                    actionSheetPopup(sender)
                }
            // Recording
            } else if currentState == State.Recording {
                switch desiredState {
                case "stop":
                    updateState(state: State.Stopped)
                case "record":
                    break
                default:
                    actionSheetPopup(sender)
                }
            // Fast Forwarding || Fast Rewinding || Paused
            } else {
                switch desiredState {
                case "play":
                    updateState(state: State.Playing)
                case "pause":
                    updateState(state: State.Paused)
                case "stop":
                    updateState(state: State.Stopped)
                case "fast rewind":
                    updateState(state: State.FRewinding)
                case "fast forward":
                    updateState(state: State.Fforwading)
                default:
                    actionSheetPopup(sender)
                }
            }
        }

    }
    
    // Updates the label to display the current state
    func updateState (state: State) {
        currentState = state
        stateLabel.text = state.name
    }
    
    // Activates/Deactivates volume, buttons and favorites
    func powerRemote(on onOrOff: Bool) {
        onOffLabel.text = onOrOff ? "On" : "Off"
        powerSwitch.setOn(onOrOff, animated: true)
        powerButtons(on: onOrOff)
    }
    
    // Activates/Deactivates the channel control buttons
    func powerButtons(on onOrOff: Bool) {
        updateState(state: State.Stopped)
        for button in stateButtons {
            button.isEnabled = onOrOff
        }
    }
    
    // Alerts the user that an unavailable option has been selected
    func actionSheetPopup(_ sender: UIButton) {
        
        let title = "Option Unavailable"
        let message = "You have selected and unavailable option. To force your selected option please press 'Confirm'"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) {
            action in self.updateState(state: State.ForcedAction)
            let okayController = UIAlertController(title: "Done!", message: "DVR will now \(sender.currentTitle!).", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            okayController.addAction(okayAction)
            self.present(okayController, animated: true, completion: nil)
            self.stateButtonsPressed(sender)
        }
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        powerRemote(on: powerLeftOn)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
