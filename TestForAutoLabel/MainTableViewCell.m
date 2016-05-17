//
//  MainTableViewCell.m
//  TestForAutoLabel
//
//  Created by 宋华 on 16/5/16.
//  Copyright © 2016年 宋华. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell


+ (MainTableViewCell *)shareInstance {
    static MainTableViewCell  *cell;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:nil options:nil] lastObject];
    });
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self sizeToFit];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
