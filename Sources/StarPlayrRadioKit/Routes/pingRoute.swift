//
//  File.swift
//  
//
//  Created by Todd Bruss on 9/11/22.
//

import Foundation
import SwifterLite

func pingRoute(pong: String) -> httpReq {{ request in    
    // reset the stream's token id
    resetChTknId = pong
    
    return HttpResponse.ok(.ping(pong, contentType: "text/plain"))
}}
