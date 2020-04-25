//
//  StorageManager.swift
//  Reciplease
//
//  Created by co5ta on 18/04/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit
import CoreData

/// Manager of the data storage
class StorageManager {
    
    /// Default instance of the class
    static let shared = StorageManager()
    /// Container that encapsulates the Core Data stack
    let persistentContainer: NSPersistentContainer
    /// Managed object context associated with the main queue
    let viewContext: NSManagedObjectContext
    
    /// Initializes an object with a custom persistent container
    init(persistentContainer: NSPersistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer) {
        self.persistentContainer = persistentContainer
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        self.viewContext = persistentContainer.viewContext
    }
    
    /// Loads all stored recipes
    func loadRecipes() throws -> [Recipe] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        let recipeEntities: [RecipeEntity]
        do { recipeEntities = try viewContext.fetch(request) }
        catch let error { throw error }
        return recipeEntities.map { Recipe(from: $0)}
    }
    
    /// Saves a recipe added in favorites
    func save(recipe: Recipe) throws {
        let recipeEntity = RecipeEntity(context: viewContext)
        recipeEntity.title = recipe.title
        recipeEntity.pictureURL = recipe.pictureURL
        recipeEntity.url = recipe.url
        recipeEntity.people = recipe.people
        recipeEntity.healthLabels = try? JSONEncoder().encode(recipe.healthLabels)
        recipeEntity.cautionLabels = try? JSONEncoder().encode(recipe.cautionLabels)
        recipeEntity.ingredients = try? JSONEncoder().encode(recipe.ingredients)
        do { try viewContext.save() }
        catch(let error) { throw error }
    }
    
    /// Deletes a recipe from favorites
    func delete(recipe: Recipe) throws {
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        let titlePredicate = NSPredicate(format: "title == %@", recipe.title)
        let urlPredicate = NSPredicate(format: "url == %@", recipe.url)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [titlePredicate, urlPredicate])
        let object = try! viewContext.fetch(fetchRequest)
        object.forEach { viewContext.delete($0) }
        do { try viewContext.save() }
        catch(let error) { throw error }
    }
}
