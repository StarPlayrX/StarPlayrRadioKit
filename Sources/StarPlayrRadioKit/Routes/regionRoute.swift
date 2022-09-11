//
//  regionRoute.swift
//  
//
//  Created by Todd Bruss on 9/11/22.
//

import Foundation
import SwifterLite

func regionRoute(region: String) -> httpReq {{ request in
    playerDomain = "player.siriusxm.\(region)"
    root = "\(playerDomain)/rest/v2/experience/modules"
    appRegion = region.uppercased()
    
    return HttpResponse.ok(.ping(appRegion, contentType: "text/plain"))
}}
