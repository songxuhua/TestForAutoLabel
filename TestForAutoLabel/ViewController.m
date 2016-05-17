//
//  ViewController.m
//  TestForAutoLabel
//
//  Created by 宋华 on 16/5/16.
//  Copyright © 2016年 宋华. All rights reserved.
//

#import "ViewController.h"
#import "MainTableViewCell.h"
#import "HeapAlgorithm.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "UITableView+FDTemplateLayoutCellDebug.h"

#define kMainTableviewCellInterface @"MainTableViewCell"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *details;
@property (strong, nonatomic) MainTableViewCell *prototypeCell;


@end

@implementation ViewController

- (void)awakeFromNib {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutMainTableView];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        long size = 50000;
//        long a[size];
//        long b[size];
//
//        for (NSInteger i = 0; i < size;i++) {
//            long ran = arc4random()%size + 1;
//            a[i] = ran;
//            b[i] = ran;
//        }
//        
//        heapSortOnce(a,sizeof(a) / sizeof(long));
//
//        sortSelect(b, sizeof(b) / sizeof(long));
//       
//    });
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSMutableArray *array = [NSMutableArray arrayWithObjects:@999,@(-888),@(-11),@(99),@1999,@88,@10,@1,@(-10), nil];
//        NSDate *date = [NSDate date];
//        [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//            return  [obj1 compare:obj2];
//        }];
//        NSLog(@"val is %f",[[NSDate date] timeIntervalSinceDate:date]);
//    });
  
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutMainTableView {
//    self.mainTableView.fd_debugLogEnabled = YES;
    [self.mainTableView registerNib:[UINib nibWithNibName:kMainTableviewCellInterface bundle:nil] forCellReuseIdentifier:kMainTableviewCellInterface];
    self.prototypeCell  = [self.mainTableView dequeueReusableCellWithIdentifier:kMainTableviewCellInterface];
    //iOS8实现自适应就是这么简单，连heightForRowAtIndexPath方法都不要实现只要设置好top和bottom约束即可.
//    self.mainTableView.estimatedRowHeight = 40;
//    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark getter
- (NSMutableArray *)details {
    return [NSMutableArray arrayWithObjects:@"金先生屌炸天金先生屌炸天金先生屌炸天金先生屌炸天金先生屌炸天金先生屌炸天金先生屌炸天金先生屌炸天",@"金先生屌炸天中华雄雕展天金先生屌炸天中华雄雕展天", @"晓伟雄掉粘贴金先生屌炸天晓伟雄掉粘贴金先生屌炸天",nil];
}

#pragma mark delegate :UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.details.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *mainviewcell = [tableView dequeueReusableCellWithIdentifier:kMainTableviewCellInterface];
    NSLog(@"mainviewcell2 is %p",mainviewcell);
    [self configureCell:mainviewcell atIndexPath:indexPath];

    return mainviewcell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    MainTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//
//    return cell.frame.size.height;
//}

- (void)configureCell:(MainTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.contentLabel.text = [self.details  objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {//iOS7上xib Tableview的自适应https://github.com/forkingdog/UITableView-FDTemplateLayoutCell
    CGFloat height = [tableView fd_heightForCellWithIdentifier:kMainTableviewCellInterface configuration:^(MainTableViewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
        NSLog(@"heigthcell is %p",cell);

    }];
    return height;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //先设置好所有的内容，这是必须的(否则得到的高度也是不准确的)
//    self.prototypeCell.contentLabel.text = [self.details  objectAtIndex:indexPath.row];
//    
//    //设置cell的临时宽度约束(不设置这个，居然是没法获取到正确值的)
//    CGFloat contentViewWidth = [UIScreen mainScreen].bounds.size.width;
//    
//    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:self.prototypeCell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
//    [self.prototypeCell.contentView addConstraint:widthFenceConstraint];
//    
//    // Auto layout engine does its math //获取到内容高度(核心方法)
//   CGFloat fittingHeight = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    //删除约束
//    [self.prototypeCell.contentView removeConstraint:widthFenceConstraint];
//    
//    //获取到修正的高度，就是那个分割线的高度吧
//    return  (fittingHeight += 1.0 / [UIScreen mainScreen].scale);
//
//}


@end
