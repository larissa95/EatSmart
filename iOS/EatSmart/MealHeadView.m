//
//  MealHeadView.m
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "MealHeadView.h"

@implementation MealHeadView
@synthesize profilePic,buy,title,hostRating,buyStatusForThisUser,cookoreatPic,cookoreatLabel;

-(id) initWithMeal:(Meal *) meal {
    self=[super init];
    
    if(self) {
        self.meal=meal;
        buyStatusForThisUser = 0;
        profilePic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PlaceholderProfileImage.png"]];
        profilePic.image = [UIImage imageNamed:@"PlaceholderProfileImage.png"];
        if(meal.profilePicString) {
            [ServerCommunication performSelectorInBackground:@selector(loadImageFromURLInBackgroundAndPutInImageView:) withObject:@[meal.profilePicString,profilePic]];
        }
        profilePic.contentMode=UIViewContentModeScaleAspectFill;
        profilePic.layer.cornerRadius=profilePic.frame.size.width/2;
        profilePic.layer.masksToBounds=YES;
        profilePic.layer.borderColor=[[UIColor grayColor] CGColor];
        profilePic.layer.borderWidth=1;
        
        [self addSubview:profilePic];
        
        buy = [UIButton buttonWithType:UIButtonTypeCustom];
        buy.layer.masksToBounds=YES;
        buy.layer.cornerRadius=6;
        buy.layer.borderColor=[[UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0] CGColor];
        buy.layer.borderWidth=1;
        [buy setTitleColor:[UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0] forState:UIControlStateNormal];

        [buy addTarget:self action:@selector(buyPress) forControlEvents:UIControlEventTouchUpInside];
        
        [buy setTitle:[NSString stringWithFormat:@"%.2f €",[meal.price floatValue]] forState:UIControlStateNormal];
        [self addSubview:buy];
        
        title = [[UILabel alloc] init];
        title.font=[UIFont fontWithName:@"Helveticaneue-light" size:25];
        title.text=meal.name;
        [self addSubview:title];
        
        
        cookoreatLabel = [[UILabel alloc] init];
        cookoreatLabel.font=[UIFont fontWithName:@"Helveticaneue-light" size:20];
        cookoreatLabel.textColor=[UIColor grayColor];
        cookoreatPic = [[UIImageView alloc] init];
        
        [self addSubview:cookoreatPic];
        [self addSubview:cookoreatLabel];
        
        
        if(meal.isCookEvent) {
            cookoreatPic.image=[UIImage imageNamed:@"Cook.png"];
            cookoreatLabel.text=@"(cook event)";
        } else {
            cookoreatLabel.text=@"(eat event)";
            cookoreatPic.image=[UIImage imageNamed:@"Eat.png"];
        }
        
        hostRating = [[UILabel alloc] init];
        
        hostRating.font=[UIFont fontWithName:@"" size:20];
        hostRating.textColor=[UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0];
        
        NSString *ratingString = @"";
        
        for(int i=0; i<[meal.rating intValue]; i++) {
            ratingString = [NSString stringWithFormat:@"%@★",ratingString];
        }
        for(int i=[meal.rating intValue]; i<5; i++) {
            ratingString = [NSString stringWithFormat:@"%@☆",ratingString];
        }
        
        hostRating.text = ratingString;
        
        [self addSubview:hostRating];
        
       

        
        
    }
    
    return self;
    
}

-(void) buyPress {
    if(buyStatusForThisUser==-1) {
        [buy setTitle:[NSString stringWithFormat:@"%.2f €",[self.meal.price floatValue]] forState:UIControlStateNormal];
        buyStatusForThisUser++;
    } else if(buyStatusForThisUser==0) {
        buyStatusForThisUser++;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Confirm"
                                                        message:@"\nPlease confirm your request. After the host has reviewed your request, you will get notified."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Buy",nil];
        alert.delegate=self;
        [alert show];
        
    } else if(buyStatusForThisUser==1) {
        [buy setTitle:@"Pending" forState:UIControlStateNormal];
        buyStatusForThisUser++;
    } else if(buyStatusForThisUser==2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pending…"
                                                        message:@"Waiting for the host to accept your request."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:@"Cancel request",nil];
        
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1 && buyStatusForThisUser == 1) {
        NSLog(@"päoj");
        [self buyPress];
    } else if(buttonIndex==1 && buyStatusForThisUser == 2) {
        buyStatusForThisUser=-1;
        [self buyPress];
    } else if(buttonIndex == 0 && buyStatusForThisUser == 1) {
        buyStatusForThisUser=0;
    }
}


-(void) layoutSubviews {
    profilePic.frame=CGRectMake(5, 5, self.frame.size.height-10, self.frame.size.height-10);
    profilePic.layer.cornerRadius=profilePic.frame.size.width/2;
    buy.frame=CGRectMake(self.frame.size.width-90, (self.frame.size.height/2)-15, 77, 30);
    title.frame=CGRectMake(self.frame.size.height+5, 5, self.frame.size.width-self.frame.size.height-10, 35);
    
    cookoreatPic.frame=CGRectMake(self.frame.size.height+5, 43, 20, 20);
    cookoreatLabel.frame=CGRectMake(self.frame.size.height+5+20, 43, 150, 20);
    hostRating.frame=CGRectMake(self.frame.size.height+5, 75, self.frame.size.width, 20);
    

    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
