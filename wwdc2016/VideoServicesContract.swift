//
//  VideoServiceContract.swift
//  wwdc2016
//
//  Created by Daniele Vitali on 29/09/2016.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

enum ServiceResult<T> {
    case error(Error)
    case data([T])
}

protocol VideoServicesContract {
    
    func getVideos(completion: @escaping (ServiceResult<Video>) -> Void)
    
}
