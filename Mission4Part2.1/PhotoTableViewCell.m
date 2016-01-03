//
//  PhotoTableViewCell.m
//  Mission4Part2.1
//
//  Created by thomas minshull on 2015-12-23.
//  Copyright © 2015 thomas minshull. All rights reserved.
//

#import "PhotoTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MBProgressHUD.h"

@implementation PhotoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setUpCellWithURL:(NSURL *)url {
    [self.photoImageView sd_setImageWithURL:url
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    NSLog(@"setUpCellWithURL: %@", url);
}

-(void)saveImage {
//    [MBProgressHUD showHUDAddedTo:self.photoImageView animated:YES];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
//    });
//    [NSThread sleepForTimeInterval:0.5f];
//    [MBProgressHUD hideHUDForView:self.photoImageView animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)saveToGallery:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.photoImageView animated:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
    });
    [NSThread sleepForTimeInterval:0.5f];
    [MBProgressHUD hideHUDForView:self.photoImageView animated:YES];
}

@end
