//
//  MainViewController.m
//  WalkerTexasRanger
//
//  Created by Chris Paveglio on 10/9/13.
//  Copyright (c) 2013 none. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize textView;
@synthesize currentElementValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSError *err;
        NSString *fileLoc = [[NSBundle mainBundle] pathForResource:@"sampleFile" ofType:@"xml"];
        plainText = [NSString stringWithContentsOfFile:fileLoc encoding:NSUTF8StringEncoding error:&err];
        xmlText = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", plainText);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [textView setText:plainText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startProcess:(id)sender
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlText];
    [parser setDelegate:self];
    currentElementValue = [NSMutableString string];
    currentObject = [[MyData alloc] init];
    elementArray = [NSMutableArray array];
    
    [parser parse];
    
    [rootObject logChildren]; //log the tree structure when parse is done
}

#pragma mark - XML Parser Delegate

/*
 to recreate a full xml file, we must use an array to hold each element as it is processed
 an object is created and added to the array. this will become our "previous" item when
 we need to go back to the previous element level
 to start, root element is made from first element. its name is set and it is added to the array
 next the first element is found. the persistent data item has the name changed.
 a copy of the persistent element is made, and then adde to the children of the root item (or previous item)
 then it is also added to the ongoing element array.
 at this time, new object is added to the children of the tree, and to the "flat" element array
 when an element ends, the last element's content/text is set. The last element of the array is the exact same
 item in memory in both the tree structure and the last item in the flat array.
 since the item text is now set and we are done with the element, delete the last element from the flat array
 it will continue to be in the tree structure
 clear out the text so if the next ending element is just a container tag, it doesn't get the left-over text added
 */

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [currentElementValue setString:@""];
    
    if (!rootObject) {
        rootObject = [[MyData alloc] init];
        [rootObject setName:elementName];
        [elementArray addObject:rootObject];
    } else {
        [currentObject setName:elementName];
        MyData *newObject = [currentObject copy];
        [[[elementArray lastObject] children] addObject:newObject];
        [elementArray addObject:newObject];
    }
    captureChars = YES;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (captureChars == YES) {
        [currentElementValue appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [[elementArray lastObject] setDataContent:[currentElementValue copy]];
    captureChars = NO; //stop gathering of comments and whitespace between elements
    [elementArray removeLastObject];
    [currentElementValue setString:@""];
}

@end
