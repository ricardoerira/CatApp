//
//  CatBreedEntity.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 7/04/25.
//

import Foundation
import CoreData

@objc(CatBreedEntity)
class CatBreedEntity: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatBreedEntity> {
         return NSFetchRequest<CatBreedEntity>(entityName: "CatBreedEntity")
     }
    
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var origin: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var breedDescription: String?
    @NSManaged public var temperament: String?
    @NSManaged public var intelligence: Int16
    @NSManaged public var adaptability: Int16
    @NSManaged public var referenceImageId: String? 
}
