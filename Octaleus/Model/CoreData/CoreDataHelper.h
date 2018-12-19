//
//  CoreDataHelper.h
//  Created by Rahul Soni on 04/10/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"


@interface CoreDataHelper : NSObject
{
    
}

+ (CoreDataHelper*) Instance;

- (NSMutableArray*) fetchWithTable:(NSString*) tableName;
- (NSMutableArray*) fetchWithTable:(NSString*) tableName withPredicate:(NSPredicate*) predicate;
- (int)countForTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate;
- (NSManagedObject*) newEntityWithTableName:(NSString*) tabelName;
- (BOOL) deleteFromData:(NSManagedObject*) obj;
- (void) saveContext;
- (BOOL) deleteAll:(NSString*) tableName;
- (BOOL)deleteAll:(NSString *)tableName withPredicate:(NSPredicate *)predicate;
- (BOOL) isExists:(NSString*) tableName predicate:(NSPredicate*) predicate;

@end
