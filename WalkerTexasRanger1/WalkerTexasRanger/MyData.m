//
//  MyData.m
//  WalkerTexasRanger
//
//  Created by Chris Paveglio on 10/9/13.
//  Copyright (c) 2013 none. All rights reserved.
//

#import "MyData.h"

@implementation MyData

@synthesize name;
@synthesize dataContent;
@synthesize children;

-(id)init
{
    self = [super init];
    if (self) {
        children = [NSMutableArray array];
//        NSLog(@"made MyData");
    }
    return self;
}

//in order to be able to make a copy of an NSObject subclass item, the class
//must conform to NSCopying protocol, which means implementing copyWithZone
//this method must set up it's ivars with a copy also
//depending on how you initialize it, you could leave out some ivars
//ie a "copy" only has certain properties but not all, of the original item

-(id)copyWithZone:(NSZone *)zone
{
    MyData *another = [[MyData alloc] init];
    another.name = [name copyWithZone:zone];
    another.dataContent = [dataContent copyWithZone:zone];
    //children not duplicated, as it should be empty!
    //children NSMutArray initialized in init method

//    NSLog(@"zone copy, %@ %@", another.name, another.dataContent);
    return another;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"MyData = %@, %@, child: %d", name, dataContent, [children count]];
}

//method needs only called once on the top level object of the tree
//and it will log all children items below it
-(void)logChildren
{
    if ([children count] > 0) {
        NSLog(@"%@, %@, children = %d", name, dataContent, [children count]);
        for (int i = 0; i < [children count]; i++) {
            [[children objectAtIndex:i] logChildren];
        }
    } else {
        NSLog(@"%@, %@, children = 0", name, dataContent);
    }
}

@end
