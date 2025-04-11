//
//  OfflineService.swift
//  CatAppTestTests
//
//  Created by Wilson Ricardo Erira  on 10/04/25.
//


import XCTest
import Combine
import CoreData
@testable import CatAppTest

final class CoreDataServiceTest: XCTestCase {
    var offlineService: CoreDataService!
    var persistentContainer: NSPersistentContainer!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
        offlineService = CoreDataService(persistentContainer: makeInMemoryContainer())
    }
    
    
    func makeInMemoryContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "CatAppTestModel") // Match your .xcdatamodeld name

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { description, error in
            XCTAssertNil(error, "Failed to load in-memory store: \(error!)")
        }

        return container
    }

    override func tearDown() {
        offlineService = nil
        persistentContainer = nil
        cancellables = nil
        super.tearDown()
    }
    

    func testFetch_WhenDataExists_ReturnsCatBreeds() {
        insertMockBreeds(count: 2)

        let expectation = expectation(description: "Should fetch cat breeds")

        // When
        offlineService.fetch([CatBreed].self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            }, receiveValue: { result in
                // Then
                XCTAssertEqual(result.count, 2)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }

    func testFetch_WhenNoData_ThrowsNoDataError() {
        let expectation = expectation(description: "Should return noDataAvailable error")

        offlineService.fetch([CatBreed].self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion,
                   case ServiceError.noDataAvailable = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Expected noDataAvailable error")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetch_WithUnsupportedType_ReturnsError() {
        let expectation = expectation(description: "Should fail with unsupportedType")

        offlineService.fetch(String.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion,
                   case ServiceError.unsupportedType = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Expected unsupportedType error")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testSave_AddsOnlyNewBreeds() {
        // Given
        let existingBreed = CatBreed(
            id: "abc", name: "Bengal", temperament: "Active", origin: "Asia",
            countryCode: "AS", description: "Smart",
            intelligence: 5, adaptability: 2, referenceImageId: "img123"
        )
        offlineService.save(item: [existingBreed])

        // When trying to save again with a duplicate + a new one
        let newBreed = CatBreed(
            id: "xyz", name: "Sphynx", temperament: "Friendly", origin: "Egypt",
            countryCode: "EG", description: "Hairless",
            intelligence: 4, adaptability: 2, referenceImageId: "img456"
        )
        offlineService.save(item: [existingBreed, newBreed])

        // Then
        let context = offlineService.persistentContainer.viewContext
        let request: NSFetchRequest<CatBreedEntity> = CatBreedEntity.fetchRequest()
        let results = try? context.fetch(request)
        XCTAssertEqual(results?.count, 2)
    }

    // MARK: - Helpers

    private func insertMockBreeds(count: Int) {
        let context = offlineService.persistentContainer.viewContext
        for i in 0..<count {
            let entity = CatBreedEntity(context: context)
            entity.id = "\(i)"
            entity.name = "Breed \(i)"
            entity.origin = "Origin"
            entity.countryCode = "CO"
            entity.breedDescription = "Desc"
            entity.temperament = "Chill"
            entity.intelligence = Int16(4)
            entity.referenceImageId = "img\(i)"
        }
        try? context.save()
    }
}


class CoreDataEntityTests: XCTestCase {
    var container: NSPersistentContainer!
    var context: NSManagedObjectContext!

    override func setUp() {
        container = makeInMemoryContainer()
        context = container.viewContext
    }

    override func tearDown() {
        container = nil
        context = nil
    }
    
    func makeInMemoryContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "CatAppTestModel") // Match your .xcdatamodeld name

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { description, error in
            XCTAssertNil(error, "Failed to load in-memory store: \(error!)")
        }

        return container
    }
}
