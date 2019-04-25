//
//  LGRichTextViewTool.m
//  tttssdsd
//
//  Created by shijiyunduan on 2019/4/25.
//  Copyright © 2019 shijiyunduan. All rights reserved.
//

#import "LGRichTextViewTool.h"

//static NSString * const urlSheme = @"LGURLSheme";
#define LGURLBASE @"LGURLSheme"
#define LGURLSHEME(index) [NSString stringWithFormat:@"%@%ld", LGURLBASE, index]
#define LGURL(index) [NSString stringWithFormat:@"%@://", LGURLSHEME(index)]

@interface LGRichTextViewTool () <UITextViewDelegate>
{
    NSAttributedString *_contentAttributedText;
}

/** defaultAttributes */
@property (nonatomic, strong) NSDictionary *defaultAttributes;

/** rangeArray */
@property (nonatomic, strong) NSMutableArray *rangeArray;

@end

@implementation LGRichTextViewTool

/** 懒加载rangeArray */
- (NSMutableArray *)rangeArray
{
    if (!_rangeArray) {
        _rangeArray = [NSMutableArray array];
    }
    return _rangeArray;
}

/** 懒加载 defaultAttributes */
- (NSDictionary *)defaultAttributes
{
    if (!_defaultAttributes) {
        _defaultAttributes = @{
                               NSForegroundColorAttributeName:[UIColor blueColor]
//                               NSFontAttributeName:[UIFont systemFontOfSize:11]
                               };
    }
    return _defaultAttributes;
}

/** 懒加载richTextView */
- (LGTextView *)richTextView
{
    if (!_richTextView) {
        _richTextView = [[LGTextView alloc] init];
        _richTextView.delegate = self;
        _richTextView.editable = NO;
    }
    return _richTextView;
}

+(instancetype)defaultTool
{
    LGRichTextViewTool *tool = [[LGRichTextViewTool alloc] init];
    [tool richTextView];
    return tool;
}

- (void)setInteractionTextArray:(NSArray *)interactionTextArray
{
    _interactionTextArray = interactionTextArray;

}

- (void)setContentText:(NSString *)contentText
{
    _contentText = contentText;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:contentText attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    
    NSString *subString = contentText;
    if (self.rangeArray.count) {
        [self.rangeArray removeAllObjects];
    }
    NSRange nextRange = NSMakeRange(0, 0);
    NSInteger index = 0;
    for (NSString *text in _interactionTextArray) {
        
        NSRange subRange = [subString rangeOfString:text];
        NSRange range = NSMakeRange(nextRange.location + subRange.location, text.length);
        [self.rangeArray addObject:NSStringFromRange(range)];
        
        [attributedStr addAttribute:NSLinkAttributeName
                              value:LGURL(index)
                  range:range];
        subString = [subString substringFromIndex:subRange.length + subRange.location];
        nextRange = NSMakeRange(range.length + range.location, 0);
        index++;
    }
}

- (void)setAttributes:(NSDictionary *)attributes
{
    if (!attributes.count) {
        _attributes = self.defaultAttributes;
        return;
    };
    _attributes = attributes;
}

- (NSAttributedString *)contentAttributedText
{
    return _contentAttributedText;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
API_AVAILABLE(ios(10.0)){
    NSLog(@"%s", __func__);
    if ([self.rangeArray containsObject:NSStringFromRange(characterRange)]) {
        NSInteger index = [self.rangeArray indexOfObject:NSStringFromRange(characterRange)];
        NSString *text = self.interactionTextArray[index];
        NSString *str = LGURLSHEME(index);
        NSString *sheme = [URL scheme];
        if ([sheme isEqualToString:str]) {
            if (self.didSelectTextBlock) {
                self.didSelectTextBlock(index, text);
            }
        }
    }
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"%s", __func__);
    if ([self.rangeArray containsObject:NSStringFromRange(characterRange)]) {
        NSInteger index = [self.rangeArray indexOfObject:NSStringFromRange(characterRange)];
        NSString *text = self.interactionTextArray[index];
        NSString *str = LGURLSHEME(index);
        NSString *sheme = [URL scheme];
        if ([sheme isEqualToString:str]) {
            if (self.didSelectTextBlock) {
                self.didSelectTextBlock(index, text);
            }
        }
    }
    return NO;
}

@end
