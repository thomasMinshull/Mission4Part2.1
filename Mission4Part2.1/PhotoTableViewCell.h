//
//  PhotoTableViewCell.h
//  Mission4Part2.1
//
//  Created by thomas minshull on 2015-12-23.
//  Copyright © 2015 thomas minshull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;

-(void)setUpCellWithURL:(NSURL *)url;
-(void)saveImage;
@end
