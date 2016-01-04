//
//  PhotoTableViewController.m
//  Mission4Part2.1
//
//  Created by thomas minshull on 2015-12-23.
//  Copyright © 2015 thomas minshull. All rights reserved.
//

#import "PhotoTableViewController.h"
#import <FlickrKit/FlickrKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "PhotoTableViewCell.h"
#import "MBProgressHUD.h"

@implementation PhotoTableViewController {
    int currentPage;
    bool isPageRefresing;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.images = [[NSMutableArray alloc] init];
    currentPage = 1;
    isPageRefresing = NO;
    
    MBProgressHUD *tableViewHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    tableViewHud.labelText = @"Loading Images";
    [self loadPage:currentPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Loading images

- (void)loadPage:(int)page {
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
    [interesting setPer_page:@"10"];
 
    if (page < 0) {
        return;
    } else {
        [interesting setPage:[NSString stringWithFormat:@"%d", page]];
        [fk call:interesting completion:^(NSDictionary *response, NSError *error) {
            // Note this is not the main thread!
            if (response) {
                for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                    NSURL *url = [fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
                    [self.images addObject:url];
                    NSLog(@"Photo URL: %@", url);
                    
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Any GUI related operations here
                    NSLog(@"back on main thread");
                    [self.tableView reloadData];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    isPageRefresing = NO;
                });
            }
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height)) {
        
        NSLog(@" scroll to bottom!");
        if(isPageRefresing == NO){
            isPageRefresing = YES;
            currentPage++;
            [self loadPage:currentPage];
        }
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.images && self.images.count) {
        return [self.images count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ImageTableViewCell" forIndexPath:indexPath];
    [cell setUpCellWithURL:self.images[indexPath.row]];
    return cell;
}

@end
