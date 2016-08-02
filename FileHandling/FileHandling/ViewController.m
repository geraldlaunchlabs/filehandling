//
//  ViewController.m
//  FileHandling
//
//  Created by LLDM on 01/08/2016.
//  Copyright © 2016 LLDM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self onPathChange:nil];
    [path1 becomeFirstResponder];
    writeFlag = 0;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onPathChange:(id)sender {
    if(writeFlag) {
    } else if(![path1.text isEqual:@""] && ![path2.text isEqual:@""]) {
        path2.hidden = NO;
        exist.hidden = YES;
        compare.hidden = NO;
        WRE.hidden = YES;
        move.hidden = NO;
        copy.hidden = NO;
        remove.hidden = YES;
        read.hidden = YES;
        write.hidden = YES;
    } else if(![path1.text isEqual:@""]) {
        path2.hidden = NO;
        exist.hidden = NO;
        compare.hidden = YES;
        WRE.hidden = NO;
        move.hidden = YES;
        copy.hidden = YES;
        remove.hidden = NO;
        read.hidden = NO;
        write.hidden = YES;
    } else {
        path2.hidden = YES;
        exist.hidden = YES;
        compare.hidden = YES;
        WRE.hidden = YES;
        move.hidden = YES;
        copy.hidden = YES;
        remove.hidden = YES;
        read.hidden = YES;
        write.hidden = NO;
    }
}

-(IBAction)fileExist:(id)sender {
    fileManager = [NSFileManager defaultManager];
    //Get documents directory
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];
    if ([fileManager fileExistsAtPath:path1.text]==YES) {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"File exists..."];
    } else {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"File does not exists..."];
    }
    [self scrollToBottom];
    
}

-(IBAction)fileCompare:(id)sender {
    if ([fileManager contentsEqualAtPath:path1.text andPath:path2.text]) {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@ & %@):\n%@",console.text,path1.text,path2.text,@"Contents match..."];
    } else {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@ & %@):\n%@",console.text,path1.text,path2.text,@"Contents does not match..."];
    }
    [self scrollToBottom];
}

// Check if Writable, Readable, and Executable
-(IBAction)fileWRE:(id)sender {
    if ([fileManager isWritableFileAtPath:path1.text]) {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"Writable..."];
    } else {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"Not writable."];
    }
    if ([fileManager isReadableFileAtPath:path1.text]) {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"Readable..."];
    } else {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"Not readable..."];
    }
    if ( [fileManager isExecutableFileAtPath:path1.text]) {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"Executable"];
    } else {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"Not executable"];
    }
    [self scrollToBottom];
}

-(IBAction)fileMove:(id)sender {
    if([fileManager moveItemAtPath:path1.text toPath:path2.text error:NULL]) {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@ %@",console.text,path1.text,@"Moved successfully to",path2.text];
    } else {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"Failed to move file..."];
    }
    [self scrollToBottom];
}

-(IBAction)fileCopy:(id)sender {
    if ([fileManager copyItemAtPath:path1.text toPath:path2.text error:NULL]) {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@ %@",console.text,path1.text,@"Copied successfully to",path2.text];
    } else {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"Failed to copy file..."];
    }
    [self scrollToBottom];
}

-(IBAction)fileRemove:(id)sender {
    if ([fileManager removeItemAtPath:path1.text error:NULL]) {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"Removed successfully..."];
    } else {
        console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",console.text,path1.text,@"Failed to remove file..."];
    }
    [self scrollToBottom];
}

-(IBAction)fileRead:(id)sender {
    NSString *dataTxt = [NSString stringWithContentsOfFile:path1.text encoding:NSUTF8StringEncoding error:nil];
    console.text = [NSString stringWithFormat:@"%@\n\n(%@) :\n",console.text,dataTxt];
    [self scrollToBottom];
}

-(IBAction)fileWrite:(id)sender {
    if(!writeFlag) {
        path1.placeholder = @"Enter File Name";
        tempConsole = console.text;
        console.text = @"";
        console.editable = YES;
        [console becomeFirstResponder];
        writeFlag = !writeFlag;
    } else {
        if(path1.text) {
            path1.text = [NSString stringWithFormat:@"/Users/lldm/Documents/%@",path1.text];
            data = [console.text dataUsingEncoding:NSUTF8StringEncoding];
            [fileManager createFileAtPath:path1.text contents:data attributes:nil];
            path1.placeholder = @"File Path 1";
            console.editable = NO;
            console.text = [NSString stringWithFormat:@"%@\n\n(%@):\n%@",tempConsole,path1.text,@"File created..."];
            path1.text=@"";
            writeFlag = !writeFlag;
        } else {
            path1.text=@"WrittenFile.rtf";
        }
    }
    [self scrollToBottom];
}

-(void) scrollToBottom {
    [console scrollRangeToVisible:NSMakeRange([console.text length], 0)];
    [console setScrollEnabled:NO];
    [console setScrollEnabled:YES];
}

@end
