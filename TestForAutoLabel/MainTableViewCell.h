//
//  MainTableViewCell.h
//  TestForAutoLabel
//
//  Created by 宋华 on 16/5/16.
//  Copyright © 2016年 宋华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+FDTemplateLayoutCellDebug.h"

@interface MainTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


+ (MainTableViewCell *)shareInstance;

@end
