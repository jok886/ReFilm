//
//  TopView.m
//  ReFilm
//
//  Created by VicChan on 5/22/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "TopView.h"
#import "TopMovieCell.h"
#import "RFViewModel.h"

#define MAIN_WIDTH   (self.frame.size.width)
#define MAIN_HEIGHT  (self.frame.size.height)

@interface TopView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end

static NSString *const reuseIdentifier = @"as";

@implementation TopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT) style:UITableViewStylePlain];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
        self.refreshControl = [[UIRefreshControl alloc]init];
        [self.refreshControl addTarget:self action:@selector(refreshMovies:) forControlEvents:UIControlEventValueChanged];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新" attributes:nil];
        self.refreshControl.tintColor = [UIColor greenColor];
        [self.tableView addSubview:self.refreshControl];
    }
    return self;
}

#pragma mark - UITableViewDelegate || UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];//[tableView dequeueReusableCellWithIdentifier:@"topCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[TopMovieCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RFViewModel *rfViewModel = [[RFViewModel alloc]init];
    [rfViewModel handleTopTableCell:cell withMovie:[self.topMovies objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.topMovies count];
}

- (void)loadWithArray:(NSArray *)movies {
    self.topMovies = movies;
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新成功" attributes:nil];
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新" attributes:nil];
    
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegate didSelectedRowAtIndex:indexPath.row];
}

- (void)refreshMovies:(UIRefreshControl *)rc {
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在刷新" attributes:nil];
    [_delegate refreshTopMovies];
}

- (void)loadError {
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新失败" attributes:nil];
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新" attributes:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
