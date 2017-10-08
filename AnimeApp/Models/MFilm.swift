//
//  MFilm.swift
//  AnimeApp
//
//  Created by Alper KARATAŞ on 02/10/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

struct MFilm:Codable {
    let id:String
    let title:String
    let description:String
    let director:String
    let producer:String
    let release_date:String
    let rt_score:String
    let people:[String]
    let species:[String]
    let locations:[String]
    let vehicles:[String]
    let url:String
}
