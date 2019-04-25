//
//  LGRichTextViewTool.h
//  tttssdsd
//
//  Created by shijiyunduan on 2019/4/25.
//  Copyright © 2019 shijiyunduan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGTextView.h"

typedef void(^DidSelectTextBlock)(NSInteger index, NSString *text);

NS_ASSUME_NONNULL_BEGIN

@interface LGRichTextViewTool : NSObject

+ (instancetype)defaultTool;

/** richTextView 富文本TextView*/
@property (nonatomic, strong) LGTextView *richTextView;

/** contentText */
@property (nonatomic, strong) NSString *contentText;

/** interactionTextArray 可交互text数组 确保该数组text顺序与contentText拼接顺序相同*/
@property (nonatomic, strong) NSArray *interactionTextArray;

/** contentAttributedText */
@property (nonatomic, strong, readonly) NSAttributedString *contentAttributedText;

/** attributes */
@property (nonatomic, strong) NSDictionary *attributes;

/** DidSelectTextBlock */
@property (nonatomic, copy) DidSelectTextBlock didSelectTextBlock;

@end

NS_ASSUME_NONNULL_END
