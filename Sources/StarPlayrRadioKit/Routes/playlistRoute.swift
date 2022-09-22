//
//  playlistRoute.swift
//  StarPlayrRadioApp
//
//  Created by Todd Bruss on 9/5/22.
//

import Foundation
import SwifterLite

var lastChannelId: String = ""
var lastIgnition : Int    = 0

func currentTimeInMiliseconds() -> Int {
    let currentDate = Date()
    let since1970 = currentDate.timeIntervalSince1970
    return Int(since1970 * 1000)
}

func playlistRoute() -> httpReq {{ request in
    autoreleasepool {
        var playlist = String()
        
        guard
            let channelid = request.params[":channelid"]
        else {
            return HttpResponse.notFound(.none)
        }
        
        if let channel = String?(String(channelid.split(separator: ".")[0])),
           let ch = userX.channels[channel] as? NSDictionary,
           let channelid = ch["channelId"] as? String {
            
            userX.channel = channelid
            
            // Ignition
            if lastChannelId != channelid {
                Session(channelid: channelid)
                lastChannelId = channelid
                lastIgnition = currentTimeInMiliseconds()
            }
                          
            // Refresh token every 480 seconds
            if (currentTimeInMiliseconds() - lastIgnition) >= 480000 {
                DispatchQueue.main.async {
                    Session(channelid: channelid)
                }
                lastIgnition = currentTimeInMiliseconds()
            }
            
            let source = Playlist(channelid: channelid)
            
            TextSync(endpoint: source) { (list) in
                guard
                    let list = list
                else {
                    return
                }
                
                func processPlaylist(_ list: String) -> String {
                    playlist = list
                    
                    //MARK: fix key path
                    playlist = playlist.replacingOccurrences(of: "key/1", with: "/api/v3/key")
                    
                    //MARK: add audio prefix
                    playlist = playlist.replacingOccurrences(of: channelid, with: "/api/v3/aac/" + channelid)
                    
                    //MARK: fix duration
                    playlist = playlist.replacingOccurrences(of: "#EXT-X-TARGETDURATION:10", with: "#EXT-X-TARGETDURATION:9")
                    
                    //MARK: this keeps the PDT in sync, go figure
                    playlist = playlist.replacingOccurrences(of: "#EXTINF:10,", with: "#EXTINF:1,")
                    
                    return playlist
                }

                playlist = processPlaylist(list)
            }
        }
        
        if !playlist.isEmpty {
            return HttpResponse.ok(.ping(playlist, contentType: "application/x-mpegURL"))
        } else {
            return HttpResponse.notFound(.none)
        }
    }
}}
