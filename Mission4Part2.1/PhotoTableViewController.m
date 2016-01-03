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

@implementation PhotoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.images = [[NSMutableArray alloc] init];
    MBProgressHUD *tableViewHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    tableViewHud.labelText = @"Loading Images";
    
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
    [interesting setPer_page:@"10"];
    [interesting setPage:@"0"];
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
            });
        }   
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

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
