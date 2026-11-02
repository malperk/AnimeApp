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
    public var baseURL: URL {
        return URL(string: "https://ghibliapi.vercel.app")!
    }

    public var path: String {
        switch self {
        case .films(let id):
            return resourcePath("films", id: id)
        case .people(let id):
            return resourcePath("people", id: id)
        case .locations(let id):
            return resourcePath("locations", id: id)
        case .species(let id):
            return resourcePath("species", id: id)
        case .vehicles(let id):
            return resourcePath("vehicles", id: id)
        }
    }

    private func resourcePath(_ resource: String, id: String?) -> String {
        guard let id = id, !id.isEmpty else {
            return "/\(resource)"
        }
        return "/\(resource)/\(id)"
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
        return ["Content-Type": "application/json"]
    }
}
