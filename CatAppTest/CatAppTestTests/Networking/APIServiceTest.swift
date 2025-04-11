//
//  APIServiceTest.swift
//  CatAppTestTests
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//


import XCTest
import Combine
@testable import CatAppTest

final class APIServiceTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    let sampleJSON = """
    [
      {
        "weight": {
          "imperial": "7  -  10",
          "metric": "3 - 5"
        },
        "id": "abys",
        "name": "Abyssinian",
        "cfa_url": "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
        "vetstreet_url": "http://www.vetstreet.com/cats/abyssinian",
        "vcahospitals_url": "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
        "temperament": "Active, Energetic, Independent, Intelligent, Gentle",
        "origin": "Egypt",
        "country_codes": "EG",
        "country_code": "EG",
        "description": "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
        "life_span": "14 - 15",
        "indoor": 0,
        "lap": 1,
        "alt_names": "",
        "adaptability": 5,
        "affection_level": 5,
        "child_friendly": 3,
        "dog_friendly": 4,
        "energy_level": 5,
        "grooming": 1,
        "health_issues": 2,
        "intelligence": 5,
        "shedding_level": 2,
        "social_needs": 5,
        "stranger_friendly": 5,
        "vocalisation": 1,
        "experimental": 0,
        "hairless": 0,
        "natural": 1,
        "rare": 0,
        "rex": 0,
        "suppressed_tail": 0,
        "short_legs": 0,
        "wikipedia_url": "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
        "hypoallergenic": 0,
        "reference_image_id": "0XYvRd7oD"
      }
    ]
    """
    
    func makeMockSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }

    func testFetchBreeds_success() {
        let session = makeMockSession()
        let service = APIService(session: session)
        let dataResponse = sampleJSON.data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, dataResponse)
        }

        let expectation = XCTestExpectation(description: "Fetch Breeds")

        service.fetch([CatBreed].self, from: "/breeds")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected failure: \(error)")
                }
            }, receiveValue: { breeds in
                XCTAssertEqual(breeds.first?.id, "abys")
                XCTAssertEqual(breeds.first?.name, "Abyssinian")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }

    func testFetchBreeds_errorStatus() {
        let session = makeMockSession()
        let service = APIService(session: session)

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 404,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, Data())
        }

        let expectation = XCTestExpectation(description: "Fetch error")

        service.fetch([CatBreed].self, from: "/breeds")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is APIError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, got success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }
}
