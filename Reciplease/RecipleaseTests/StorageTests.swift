//
//  StorageTests.swift
//  RecipleaseTests
//
//  Created by co5ta on 18/04/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

/// A class to check the proper functioning of the storage
class StorageTests: XCTestCase {
    
    /// An array to stock recipes loaded from storage
    var rows = [Recipe]()
    
    /// A copy of the representation of the .xcdatamodeld file describing the objects
    static let managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    /// The store manager configured for tests
    let storageManager: StorageManager = {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        let container = NSPersistentContainer(name: "Reciplease", managedObjectModel: StorageTests.managedObjectModel)
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error { fatalError("In memory coordinator creation failed \(error)") }
        }
        return StorageManager(persistentContainer: container)
    }()
    
    /// Tests the saving and loading of recipes
    func testRecipesSavingAndLoading() {
        // Saving
        let recipes = FakeData.recipes
        recipes.forEach {
            do { try storageManager.save(recipe: $0) }
            catch (let error) { XCTFail(error.localizedDescription) }
        }
        // Loading
        do { rows = try storageManager.loadRecipes() }
        catch (let error) { XCTFail(error.localizedDescription) }
        // Test
        XCTAssertEqual(recipes, rows)
    }
    
    /// Tests the deletion of recipe
    func testRecipeDeletion() {
        // Saving
        let recipes = FakeData.recipes
        recipes.forEach {
            do { try storageManager.save(recipe: $0) }
            catch (let error) { XCTFail(error.localizedDescription) }
        }
        // Deleting
        let random = Int.random(in: 0..<recipes.count)
        let recipeToDelete = recipes[random]
        do { try storageManager.delete(recipe: recipeToDelete) }
        catch (let error) { XCTFail(error.localizedDescription) }
        // Loading
        do { rows = try storageManager.loadRecipes() }
        catch (let error) { XCTFail(error.localizedDescription) }
        // Test
        XCTAssertEqual(rows.count, recipes.count - 1)
        let recipesDeleted = recipes.filter { rows.contains($0) == false }
        XCTAssertEqual(recipesDeleted.count, 1)
        XCTAssertEqual(recipeToDelete, recipesDeleted[0])
    }
}
