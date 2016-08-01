//
//  ViewController.h
//  FileHandling
//
//  Created by LLDM on 01/08/2016.
//  Copyright © 2016 LLDM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextViewDelegate> {
    NSFileManager *fileManager;
    NSData *data;
    IBOutlet UIButton *exist;
    IBOutlet UIButton *compare;
    IBOutlet UIButton *WRE;
    IBOutlet UIButton *move;
    IBOutlet UIButton *copy;
    IBOutlet UIButton *remove;
    IBOutlet UIButton *read;
    IBOutlet UIButton *write;
    IBOutlet UITextField *path1;
    IBOutlet UITextField *path2;
    IBOutlet UITextView *console;
    bool writeFlag;
    NSString *tempConsole;
}

- (IBAction)onPathChange:(id)sender;
-(IBAction)fileExist:(id)sender;
-(IBAction)fileCompare:(id)sender;
-(IBAction)fileWRE:(id)sender;
-(IBAction)fileMove:(id)sender;
-(IBAction)fileCopy:(id)sender;
-(IBAction)fileRemove:(id)sender;
-(IBAction)fileRead:(id)sender;
-(IBAction)fileWrite:(id)sender;

@end

