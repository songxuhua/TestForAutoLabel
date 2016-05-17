//
//  HeapAlgorithm.m
//  TestForAutoLabel
//
//  Created by 宋华 on 16/5/16.
//  Copyright © 2016年 宋华. All rights reserved.
//

#import "HeapAlgorithm.h"

@implementation HeapAlgorithm

void initHeap(long a[],long len) {
    for (long i = (len - 1) / 2; i >= 0; --i) {
        adjustMaxHeap(a, len, i);
    }
}

void adjustMaxHeap(long a[], long len, long parentNodeIndex) {
    // 若只有一个元素，那么只能是堆顶元素，也没有必要再排序了
    if (len <= 1) {
        return;
    }
    
    // 记录比父节点大的左孩子或者右孩子的索引
    long targetIndex = -1;
    
    // 获取左、右孩子的索引
    long leftChildIndex = 2 * parentNodeIndex + 1;
    long rightChildIndex = 2 * parentNodeIndex + 2;
    
    // 没有左孩子
    if (leftChildIndex >= len) {
        return;
    }
    
    // 有左孩子，但是没有右孩子
    if (rightChildIndex >= len) {
        targetIndex = leftChildIndex;
    }
    // 有左孩子和右孩子
    else {
        // 取左、右孩子两者中最大的一个
        targetIndex = a[leftChildIndex] > a[rightChildIndex] ? leftChildIndex : rightChildIndex;
    }
    
    // 只有孩子比父节点的值还要大，才需要交换
    if (a[targetIndex] > a[parentNodeIndex]) {
        long temp = a[targetIndex];
        
        a[targetIndex] = a[parentNodeIndex];
        a[parentNodeIndex] = temp;
        
        
        // 交换完成后，有可能会导致a[targetIndex]结点所形成的子树不满足堆的条件，
        // 若不满足堆的条件，则调整之使之也成为堆
        adjustMaxHeap(a, len, targetIndex);
    }
}

void heapSortOnce(long a[], long len) {
    NSDate *lastDate = [NSDate date];
    if (len <= 1) {
        return;
    }
    
    // 初始堆成无序最大堆
    initHeap(a, len);
    
    for (long i = len - 1; i > 0; --i) {
        // 将当前堆顶元素与最后一个元素交换，保证这一趟所查找到的堆顶元素与最后一个元素交换
        // 注意：这里所说的最后不是a[len - 1]，而是每一趟的范围中最后一个元素
        // 为什么要加上>0判断？每次不是说堆顶一定是最大值吗？没错，每一趟调整后，堆顶是最大值的
        // 但是，由于len的范围不断地缩小，导致某些特殊的序列出现异常
        // 比如说，5, 3, 8, 6, 4序列，当调整i=1时，已经调整为3,4,5,6,8序列，已经有序了
        // 但是导致了a[i]与a[0]交换，由于变成了4,3,5,6,8反而变成无序了!
        if (a[0] > a[i]) {
            long temp = a[0];
            a[0] = a[i];
            a[i] = temp;
        }
        
        // 范围变成为：
        // 0...len-1
        // 0...len-1-1
        // 0...1 // 结束
        // 其中，0是堆顶，每次都是找出在指定的范围内比堆顶还大的元素，然后与堆顶元素交换
        adjustMaxHeap(a, i - 1, 0);
    }
    NSTimeInterval val = [[NSDate date] timeIntervalSinceDate:lastDate];
    NSLog(@" heapSortOnce val is %f",val);
}

void DataSwap(long* data1, long* data2)
{
    long temp = *data1;
    *data1 = *data2;
    *data2 = temp;
}

void sortSelect(long a[], long len) {
    NSDate *lastDate = [NSDate date];
    for (long i = 0; i < len - 1; i++)    //从第一个位置开始
    {
        long index = i;
        for (long j = i + 1; j < len; j++)    //寻找最小的数据索引
            if (a[j] < a[index])
                index = j;
        
        if (index != i)    //如果最小数位置变化则交换
            DataSwap(&a[index], &a[i]);
    }
    NSLog(@"sortSelect val is %f",[[NSDate date] timeIntervalSinceDate:lastDate]);

}


@end
