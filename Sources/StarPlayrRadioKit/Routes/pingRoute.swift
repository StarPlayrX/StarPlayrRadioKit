//
//  File.swift
//  
//
//  Created by Todd Bruss on 9/11/22.
//

import Foundation
import SwifterLite

func pingRoute(pong: String) -> httpReq {{ request in
    resetChTknId = pong //this will reset the strean's token id
    HttpResponse.ok(.ping(pong, contentType: "text/plain"))
}}
