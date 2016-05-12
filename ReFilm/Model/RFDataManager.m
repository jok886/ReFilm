//
//  RFDataManager.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "RFDataManager.h"
#import "RFNetworkManager.h"

@interface RFParser()

@end

@implementation RFParser

+ (Movie *)parserForMovie:(NSDictionary *)data {
    Movie *movie = [Movie new];
    
    return movie;
}

@end








@interface RFDataManager()

@end

@implementation RFDataManager

+ (RFDataManager *)sharedManager {
    static RFDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc]init];
    });
    
    return sharedManager;
}

- (void)sendRequestForHotMovies {
    NSString *urlString = @"http://api.douban.com/v2/movie/in_theaters";
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:urlString success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSLog(@"--%s,%@",__func__,responseObject);
    } failure:^(NSError *error, NSString *errorMsg) {
        NSLog(@"error : %@",errorMsg);
    }];
}

- (void)sendRequestForCommingMovies {
    NSString *urlString = @"http://api.douban.com/v2/movie/coming_soon";
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:urlString success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSLog(@"--%s----%@",__func__,responseObject);
    } failure:^(NSError *error, NSString *errorMsg) {
        NSLog(@"error: %@",errorMsg);
    }];
}

- (void)sendRequestForTop100Movies {
    NSString *urlString = @"http://api.douban.com/v2/movie/top250";
    RFNetworkManager *manager = [RFNetworkManager sharedManager];
    [manager requestMovieDataWithURL:urlString success:^(NSDictionary *responseObject, NSURLResponse *response) {
        NSLog(@"--%s----%@",__func__,responseObject);

    } failure:^(NSError *error, NSString *errorMsg) {
        NSLog(@"error %@",errorMsg);
    }];
}


@end
