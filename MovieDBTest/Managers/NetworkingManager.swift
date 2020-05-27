//
//  NetworkingManager.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 26.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation
import SystemConfiguration

class NetworkingManager {
  private var session: URLSession
  private var dataTask: URLSessionDataTask?
  private var timer = Timer()
  static let shared = NetworkingManager()
  
  init() {
    let configuration = URLSessionConfiguration.default
    session = URLSession(configuration: configuration)
  }
  
  func handleConnection(completion: @escaping (Bool) -> Void) {
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [unowned self] _ in
      var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
      zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
      zeroAddress.sin_family = sa_family_t(AF_INET)
      
      let defaultRoute = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
          SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
      }
      
      var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
      if SCNetworkReachabilityGetFlags(defaultRoute!, &flags) == false {
        if self.dataTask != nil {
          self.dataTask?.suspend()
        }
        
        DispatchQueue.main.async {
          completion(false)
        }
      }
      
      let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
      let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
      
      let ret = isReachable && !needsConnection
      
      if self.dataTask != nil {
        if ret {
          self.dataTask?.resume()
        } else {
          self.dataTask?.suspend()
        }
      }
      
      DispatchQueue.main.async {
        completion(ret)
      }
    })
    
    timer.fire()
  }
  
  func startGetTask<ObjectType: Codable>(forURL url: String, object: ObjectType.Type, completion: @escaping (ObjectType?, Error?) -> Void) {
    guard let url = URL(string: [url, API.authKey].joined()) else {
      completion(nil, NetworkError.invalidURL)
      return
    }
    
    dataTask = session.dataTask(with: url) { data, response, error in
      if error != nil || data == nil {
        DispatchQueue.main.async {
          completion(nil, error)
        }
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let object = try decoder.decode(object, from: data!)
        DispatchQueue.main.async {
          completion(object, nil)
        }
      } catch {
        DispatchQueue.main.async {
          completion(nil, error)
        }
      }
    }
    
    dataTask?.resume()
  }
  
  func downloadImage(forURL urlStr: String, completion: @escaping (Data?, Error?) -> ()) {
    guard let url = URL(string: [API.imageBase, urlStr].joined()) else { return }
    dataTask = session.dataTask(with: url) { data, response, error in
      if error != nil || data == nil {
        completion(nil, error)
        return
      }
      DispatchQueue.main.async {
        CacheManager.shared.cacheImage(data, byKey: urlStr)
        completion(data, error)
      }
    }
    
    dataTask?.resume()
  }
}

// MARK: - Custom networking errors
enum NetworkError: Error {
  case invalidURL
  case dataIsEmpty
  case invalidBody
}
