//
//  AnimeAppTests.swift
//  AnimeAppTests
//
//  Created by Alper KARATAŞ on 09/08/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import XCTest
@testable import AnimeApp

class AnimeAppTests: XCTestCase {
    func testStudioGhibliBaseURL() {
        XCTAssertEqual(
            StudioGhibli.films(id: nil).baseURL.absoluteString,
            "https://ghibliapi.vercel.app"
        )
    }

    func testEndpointPathsWithoutIDs() {
        XCTAssertEqual(StudioGhibli.films(id: nil).path, "/films")
        XCTAssertEqual(StudioGhibli.people(id: nil).path, "/people")
        XCTAssertEqual(StudioGhibli.locations(id: nil).path, "/locations")
        XCTAssertEqual(StudioGhibli.species(id: nil).path, "/species")
        XCTAssertEqual(StudioGhibli.vehicles(id: nil).path, "/vehicles")
    }

    func testEndpointPathsWithIDs() {
        XCTAssertEqual(StudioGhibli.films(id: "123").path, "/films/123")
        XCTAssertEqual(StudioGhibli.people(id: "123").path, "/people/123")
        XCTAssertEqual(StudioGhibli.locations(id: "123").path, "/locations/123")
        XCTAssertEqual(StudioGhibli.species(id: "123").path, "/species/123")
        XCTAssertEqual(StudioGhibli.vehicles(id: "123").path, "/vehicles/123")
    }

    func testFilmDecodesPosterURL() throws {
        let json = """
        {
          "id": "film-1",
          "title": "My Neighbor Totoro",
          "description": "Film description",
          "director": "Hayao Miyazaki",
          "producer": "Hayao Miyazaki",
          "release_date": "1988",
          "rt_score": "93",
          "people": [],
          "species": [],
          "locations": [],
          "vehicles": [],
          "url": "https://ghibliapi.vercel.app/films/film-1",
          "image": "https://image.tmdb.org/t/p/example.jpg"
        }
        """

        let data = json.data(using: .utf8)!
        let film = try JSONDecoder().decode(MFilm.self, from: data)

        XCTAssertEqual(film.title, "My Neighbor Totoro")
        XCTAssertEqual(film.image, "https://image.tmdb.org/t/p/example.jpg")
    }

    func testFilmCanDecodeWithoutPosterURL() throws {
        let json = """
        {
          "id": "film-1",
          "title": "My Neighbor Totoro",
          "description": "Film description",
          "director": "Hayao Miyazaki",
          "producer": "Hayao Miyazaki",
          "release_date": "1988",
          "rt_score": "93",
          "people": [],
          "species": [],
          "locations": [],
          "vehicles": [],
          "url": "https://ghibliapi.vercel.app/films/film-1"
        }
        """

        let data = json.data(using: .utf8)!
        let film = try JSONDecoder().decode(MFilm.self, from: data)

        XCTAssertNil(film.image)
    }
}
