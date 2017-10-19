//
//  DataService.swift
//  USStatesApp
//
//  Created by vamsi krishna reddy kamjula on 10/19/17.
//  Copyright © 2017 kvkr. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias CompletionHandler = (_ Success: Bool) -> ()

class DataService {
    static let instance = DataService()
    
    var stateDetails = [State]()
    
    func statesInfo(urlString: String, completion: @escaping CompletionHandler) {
        let url = URL(string: urlString)
        self.stateDetails.removeAll()
        Alamofire.request(url!).responseJSON { (response) in
            if response.error != nil {
                completion(false)
                return
            }
            let json = JSON(response.data!)
            guard let restResponse = json["RestResponse"].dictionary else {
                completion(false)
                return
            }
            guard let results = restResponse["result"]?.arrayValue else {
                completion(false)
                return
            }
            for result in results {
                let stateId = result["id"].stringValue
                let stateName = result["name"].stringValue
                let stateCapital = result["capital"].stringValue
                let stateAbbr = result["abbr"].stringValue
                let stateArea = result["area"].stringValue
                let stateLargestCity = result["largest_city"].stringValue
                let countryName = result["country"].stringValue
                
                let state = State(id: stateId, name: stateName, capital: stateCapital, area: stateArea, abbr: stateAbbr, largestCity: stateLargestCity, country: countryName)
                self.stateDetails.append(state)
            }
            completion(true)
        }
        
    }
}
