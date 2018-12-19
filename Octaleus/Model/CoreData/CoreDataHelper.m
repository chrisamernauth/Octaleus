//
//  CoreDataHelper.m
//
//
//  Created by Rahul Soni on 04/10/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.

#import "CoreDataHelper.h"

static CoreDataHelper *Singlton = nil;

@implementation CoreDataHelper

+ (CoreDataHelper*) Instance
{
    if(Singlton == nil){
        Singlton = [[CoreDataHelper alloc] init];   
    }
    return Singlton; 
    
}

- (NSMutableArray *)fetchWithTable:(NSString *)tableName {
    return [self fetchWithTable:tableName withPredicate:nil];
}

- (NSMutableArray *)fetchWithTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate {
    NSMutableArray * __autoreleasing mutableFetchResults = [[NSMutableArray alloc] init];
    @try {
        NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:[AppDelegate appDelegate].managedObjectContext];
        
        // Setup the fetch request
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        if (predicate) {
            [request setPredicate:predicate];
        }
        
        mutableFetchResults = [[[AppDelegate appDelegate].managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        return mutableFetchResults;
    }
   
    return mutableFetchResults;
}

- (int)countForTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:[AppDelegate appDelegate].managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    if (predicate) {
        [request setPredicate:predicate];
    }
    
    int count = (int)[[AppDelegate appDelegate].managedObjectContext countForFetchRequest:request error:nil];
    
    return count;
}

- (BOOL)isExists:(NSString *)tableName predicate:(NSPredicate *)predicate {
    NSMutableArray *arr = [self fetchWithTable:tableName withPredicate:predicate];
    if (arr.count > 0) {
        return YES;
    }
    return NO;
}

- (NSManagedObject *)newEntityWithTableName:(NSString *)tabelName{
    return [NSEntityDescription insertNewObjectForEntityForName:tabelName inManagedObjectContext:[AppDelegate appDelegate].managedObjectContext];
}

- (BOOL)deleteFromData:(NSManagedObject *)obj {
    [[AppDelegate appDelegate].managedObjectContext deleteObject:obj];
    NSError *error;
    [[AppDelegate appDelegate].managedObjectContext save:&error];
    if (error) {
        return NO;
    }
    return YES;
}

- (void)saveContext {
    [[AppDelegate appDelegate] saveContext];
}

- (BOOL)deleteAll:(NSString *)tableName {
    NSMutableArray *arr = [self fetchWithTable:tableName];
    if (arr) {
        for (NSManagedObject *obj in arr) {
            
            [[AppDelegate appDelegate].managedObjectContext deleteObject:obj];
        }
        
        NSError *error;
        if (![[AppDelegate appDelegate].managedObjectContext save:&error]) {
            NSLog(@"Error deleting %@ - error:%@",tableName,error);
            return NO;
        }
        return YES;
    }
    return NO;
}

- (BOOL)deleteAll:(NSString *)tableName withPredicate:(NSPredicate *)predicate{
    NSMutableArray *arr = [self fetchWithTable:tableName withPredicate:predicate];
    if (arr) {
        for (NSManagedObject *obj in arr) {
            
            [[AppDelegate appDelegate].managedObjectContext deleteObject:obj];
        }
        
        NSError *error;
        if (![[AppDelegate appDelegate].managedObjectContext save:&error]) {
            NSLog(@"Error deleting %@ - error:%@",tableName,error);
            return NO;
        }
        return YES;
    }
    return NO;
}

@end
