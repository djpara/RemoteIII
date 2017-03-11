//
//  FavoriteChannels.swift
//  ParaD_RemoteIII
//
//  Created by David Para on 3/1/17.
//  Copyright © 2017 David Para. All rights reserved.
//

import Foundation

// Default favorites
let favoriteChannels = [
    favoriteChannel(channelNum: "17",
                    channelName: "HBO"),
    favoriteChannel(channelNum: "58",
                    channelName: "ESPN"),
    favoriteChannel(channelNum: "30",
                    channelName: "CSN"),
    favoriteChannel(channelNum: "40",
                    channelName: "CNN"),
]

class favoriteChannel {
    
    var channelNum: String
    var channelName: String

    init (channelNum: String, channelName: String) {
        self.channelNum = channelNum
        self.channelName = channelName
    }
    
    func getChannelNumber() -> String {
        return channelNum
    }
    
    func getChannelName() -> String {
        return channelName
    }
    
    func setChannelNumber(to channelNum: String) {
        self.channelNum = channelNum
    }
    
    func setChannelName(to channelName: String) {
        self.channelName = channelName
    }
    
}
