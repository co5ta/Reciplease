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
    
    /// List of all stored recipes
    static var list: [Recipe] = []
    
    /// Loads all stored recipes
    static func loadAll() -> [Recipe] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let recipeEntities = try? AppDelegate.viewContext.fetch(request) else { return [] }
        var recipes = [Recipe]()
        recipeEntities.forEach { (recipeEntity) in
            let health = try? JSONDecoder().decode([String].self, from: recipeEntity.healthLabels!)
            let cautions = try? JSONDecoder().decode([String].self, from: recipeEntity.cautionsLabels!)
            let ingredients = try? JSONDecoder().decode([String].self, from: recipeEntity.ingredients!)
            let recipe = Recipe(
                title: recipeEntity.title!,
                pictureUrl: recipeEntity.pictureURL!,
                url: recipeEntity.url!,
                people: recipeEntity.people,
                healthLabels: health!,
                cautionLabels: cautions!,
                ingredients: ingredients!)
            recipes.append(recipe)
        }
        return recipes
    }
    
    /// Saves a recipe added in favorites
    static func save(recipe: Recipe) {
        let recipeEntity = RecipeEntity(context: AppDelegate.viewContext)
        recipeEntity.title = recipe.title
        recipeEntity.pictureURL = recipe.pictureUrl
        recipeEntity.url = recipe.url
        recipeEntity.people = recipe.people
        recipeEntity.healthLabels = try? JSONEncoder().encode(recipe.healthLabels)
        recipeEntity.cautionsLabels = try? JSONEncoder().encode(recipe.cautionLabels)
        recipeEntity.ingredients = try? JSONEncoder().encode(recipe.ingredients)
        try? AppDelegate.viewContext.save()
    }
    
    /// Deletes a recipe from favorites
    static func delete(recipe: Recipe) {
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", recipe.title)
        let object = try! AppDelegate.viewContext.fetch(fetchRequest)
        //AppDelegate.viewContext.delete(object)
        object.forEach { AppDelegate.viewContext.delete($0) }
    }
}
