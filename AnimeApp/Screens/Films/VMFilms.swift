//
//  VMFilms.swift
//  AnimeApp
//
//  Created by Alper KARATAŞ on 02/10/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation
import RxSwift

class VMFilms {
    private let disposeBag = DisposeBag()
    var data: Single<[MFilm]> = {
        return studioGhibliProvider
            .rx.request(.films(id: nil)).filter(statusCode: 200)
            .mapJSONObject(type: [MFilm].self)
    }()
    
    init() {
    }
}
