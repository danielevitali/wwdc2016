//
//  NetworkingManagerContract.swift
//  wwdc2016
//
//  Created by Daniele Vitali on 29/09/2016.
//  Copyright © 2016 Daniele Vitali. All rights reserved.
//

import Foundation

protocol NetworkingManagerContract {
    
    func getData(with url:URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    
}
