//
//  MainViewController.h
//  WalkerTexasRanger
//
//  Created by Chris Paveglio on 10/9/13.
//  Copyright (c) 2013 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyData.h"

@interface MainViewController : UIViewController <NSXMLParserDelegate>
{
    NSData *xmlText;
    NSString *plainText;
    NSMutableString *currentElementValue;
    MyData *rootObject;
    MyData *currentObject;
    
    NSMutableArray *elementArray; //required to keep track of previous elements
    
    BOOL captureChars;
}

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) NSMutableString *currentElementValue;


- (IBAction)startProcess:(id)sender;

@end
