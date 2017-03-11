//
//  ViewController.swift
//  ParaD_Remote
//
//  Created by David Para on 1/31/17.
//  Copyright © 2017 David Para. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var onOffLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    
    @IBOutlet weak var channelUpButton: UIButton!
    @IBOutlet weak var channelDownButton: UIButton!
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    
    @IBOutlet weak var powerSwitch: UISwitch!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var favoritesSegControl: UISegmentedControl!
    
    var DVRPowerLeftOn: Bool = false
    
    var currentChannel: String = ""
    
    // List of all buttons. Easier to control when adding more buttons and then turning them on and off.
    lazy var buttons: [UIButton] = [self.channelUpButton, self.channelDownButton, self.zero, self.one, self.two, self.three, self.four, self.five, self.six, self.seven, self.eight, self.nine]
    
    // Power Switch: on or off
    @IBAction func PowerSwitch(_ sender: UISwitch) {
        onOffLabel.text = sender.isOn ? "On" : "Off"
        
        let onOrOff = (sender.isOn == true)
        remotePower(on: onOrOff)
    }

    // Volume control
    @IBAction func VolumeSlider(_ sender: UISlider) {
        volumeLabel.text = "\(Int(sender.value))"
    }
    
    // Channel up or down decision
    @IBAction func channelStep(_ sender: UIButton) {
        self.favoritesSegControl.selectedSegmentIndex = UISegmentedControlNoSegment
        if let upOrDown = sender.currentTitle {
            
            switch upOrDown {
            case "Ch +":
                channelUp()
            case "Ch -":
                channelDown()
            default:
                break
            }
            
        }
    }
    
    // Gets the channel number and concats a string of max count == 2. If count > 2, begins new string. Channel strings must be equal to 2. If user wants channel 01, user must press 0 and then 1.
    @IBAction func channelNumbers(_ sender: UIButton) {
        self.favoritesSegControl.selectedSegmentIndex = UISegmentedControlNoSegment
        if let channel = sender.currentTitle {
            if channelLabel.text == "0" && channel == "0" {
                channelLabel.text = "01"
            } else {
                if channelLabel.text?.characters.count != nil {
                    var digits = channelLabel.text?.characters.count
                    if digits! < 2 {
                        channelLabel.text?.append(channel)
                        digits! += 1
                        if digits == 2 {
                            self.currentChannel = channelLabel.text!
                        }
                    } else {
                        channelLabel.text = channel
                    }
                }
            }
        }
    }
    
    // Favorite Channel
    @IBAction func favoriteChannelSegControl(_ sender: UISegmentedControl) {
        let favorite = sender.selectedSegmentIndex
        switch favorite {
        case 0:
            currentChannel = favoriteChannels[0].getChannelNumber()
            channelLabel.text = currentChannel
        case 1:
            currentChannel = favoriteChannels[1].getChannelNumber()
            channelLabel.text = currentChannel
        case 2:
            currentChannel = favoriteChannels[2].getChannelNumber()
            channelLabel.text = currentChannel
        case 3:
            currentChannel = favoriteChannels[3].getChannelNumber()
            channelLabel.text = currentChannel
        default:
            break
        }
    }
    
    // Gets current channel text, increases the number and prints to the channel label
    func channelUp () {
        var channel = Int(self.currentChannel)
        if channel == 99 {
            channel = 01
        } else {
            channel! += 1
        }
        currentChannel = String(format: "%02d", channel!)
        channelLabel.text = currentChannel
    }
    
    // Gets current channel text, decreases the number and prints to the channel label
    func channelDown () {
        var channel = Int(currentChannel)
        if channel == 01 {
            channel = 99
        } else {
            channel! -= 1
        }
        currentChannel = String(format: "%02d", channel!)
        channelLabel.text = currentChannel
    }
    
    // Activates/Deactivates volume, buttons and favorites
    func remotePower(on onOrOff: Bool) {
        volumePower(on: onOrOff)
        buttonsPower(on: onOrOff)
        favoritesPower(on: onOrOff)
    }
    
    // Activates/Deactivates the volume slider
    func volumePower(on OnOrOff: Bool) {
        volumeSlider.isEnabled = OnOrOff
    }
    
    // Activates/Deactivates the channel control buttons
    func buttonsPower(on onOrOff: Bool) {
        for button in buttons {
            button.isEnabled = onOrOff
        }
    }
    
    // Activates/Deactivates the favorites controls
    func favoritesPower(on onOrOff: Bool) {
        favoritesSegControl.isEnabled = onOrOff
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remotePower(on: false)
        if channelLabel.text != nil {
            currentChannel  = channelLabel.text!
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritesSegControl.setTitle(favoriteChannels[0].channelName,
                                     forSegmentAt: 0)
        favoritesSegControl.setTitle(favoriteChannels[1].channelName,
                                     forSegmentAt: 1)
        favoritesSegControl.setTitle(favoriteChannels[2].channelName,
                                     forSegmentAt: 2)
        favoritesSegControl.setTitle(favoriteChannels[3].channelName,
                                     forSegmentAt: 3)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let target = segue.destination as? DVRViewController {
//            target.powerLeftOn = DVRPowerLeftOn
//        }
//    }
    
}

