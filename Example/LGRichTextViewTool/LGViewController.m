//
//  LGViewController.m
//  LGRichTextViewTool
//
//  Created by 332718748@qq.com on 04/25/2019.
//  Copyright (c) 2019 332718748@qq.com. All rights reserved.
//

#import "LGViewController.h"
#import <LGRichTextViewTool/LGRichTextViewTool.h>

@interface LGViewController ()

/** tool */
@property (nonatomic, strong) LGRichTextViewTool *tool;

@end

@implementation LGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    LGRichTextViewTool *tool = [LGRichTextViewTool defaultTool];
    self.tool = tool;
    [self.view addSubview:tool.richTextView];
    
    tool.richTextView.frame = CGRectMake(50, 200, 100, 100);
    
    NSArray *array = @[@"测试1", @"测试2", @"测试3", @"测试4", @"测试4", @"测试5", @"测试3"];
    tool.interactionTextArray = array;
    
    NSMutableString *s = [NSMutableString stringWithString:@"哈哈哈哈哈"];
    [s appendString:[array componentsJoinedByString:@" "]];
    [s appendString:@"heheheh"];
    tool.contentText = s;
    
    tool.didSelectTextBlock = ^(NSInteger index, NSString *text) {
        NSLog(@"选中位置：%ld, 选中文字：%@", index, text);
    };
}


@end
