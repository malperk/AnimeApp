//
//  SGAPI.swift
//  AnimeApp
//
//  Created by Alper KARATAŞ on 04/10/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation
import Moya

public enum StudioGhibli {
    case films(id: String?)
    case people(id: String?)
    case locations(id: String?)
    case species(id: String?)
    case vehicles(id: String?)
}

extension StudioGhibli: TargetType {
    public var baseURL: URL { return URL(string: "https://ghibliapi.herokuapp.com")! }
    
    public var path: String {
        switch self {
        case .films(let id):
            var url = "/films"
            if let filmId = id { url += filmId }
            return url
        case .people(let id):
            var url = "/films"
            if let peopleId = id { url += peopleId }
            return url
        case .locations(let id):
            var url = "/locations"
            if let locationsId = id { url += locationsId }
            return url
        case .species(let id):
            var url = "/films"
            if let speciesId = id { url += speciesId }
            return url
        case .vehicles(let id):
            var url = "/films"
            if let vehiclesId = id { url += vehiclesId }
            return url
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
