//
//  File.swift
//  
//
//  Created by Todd Bruss on 9/11/22.
//

import Foundation
import SwifterLite

func pingRoute(pong: String) -> httpReq {{ request in
    HttpResponse.ok(.ping(pong, contentType: "text/plain"))
}}
