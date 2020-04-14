//
//  RecipeEntity.swift
//  Reciplease
//
//  Created by co5ta on 01/04/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import Foundation
import CoreData

/// An object that manage recipe data for core data
class RecipeEntity: NSManagedObject {
    
    /// Loads all stored recipes
    static func loadAll() throws -> [Recipe] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        let recipeEntities: [RecipeEntity]
        do { recipeEntities = try AppDelegate.viewContext.fetch(request) }
        catch let error { throw error }
        return recipeEntities.map { Recipe(from: $0)}
    }
    
    /// Saves a recipe added in favorites
    static func save(recipe: Recipe) throws {
        let recipeEntity = RecipeEntity(context: AppDelegate.viewContext)
        recipeEntity.title = recipe.title
        recipeEntity.pictureURL = recipe.pictureURL
        recipeEntity.url = recipe.url
        recipeEntity.people = recipe.people
        recipeEntity.healthLabels = try? JSONEncoder().encode(recipe.healthLabels)
        recipeEntity.cautionLabels = try? JSONEncoder().encode(recipe.cautionLabels)
        recipeEntity.ingredients = try? JSONEncoder().encode(recipe.ingredients)
        do { try AppDelegate.viewContext.save() }
        catch(let error) { throw error }
    }
    
    /// Deletes a recipe from favorites
    static func delete(recipe: Recipe) throws {
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", recipe.title)
        let object = try! AppDelegate.viewContext.fetch(fetchRequest)
        object.forEach { AppDelegate.viewContext.delete($0) }
        do { try AppDelegate.viewContext.save() }
        catch(let error) { throw error }
    }
}
