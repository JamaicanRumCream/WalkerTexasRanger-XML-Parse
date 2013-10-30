//
//  MyData.h
//  WalkerTexasRanger
//
//  Created by Chris Paveglio on 10/9/13.
//  Copyright (c) 2013 none. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyData : NSObject //<NSCopying> removed from this example
{
    NSString *name;
    NSString *dataContent;
    NSMutableArray *children;
//    MyData *parent; //not sure parent is really needed
                      //creates an infinite retain loop too
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *dataContent;
@property (nonatomic, retain) NSMutableArray *children;

-(void)logChildren;

@end
