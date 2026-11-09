//
//  APIEndpoint.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 9/11/26.
//

import Foundation

enum APIEndopoint {
  
  static let baseURL = "http://127.0.0.1:8000"
  static let users = "\(baseURL)/users/"
  static let appointments = "\(baseURL)/appointments/"
  static let payments = "\(baseURL)/payments/"
  static let lawyers = "\(baseURL)/lawyers/"
  static let clients = "\(baseURL)/clients/"
  
}
