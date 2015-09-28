//
//  ViewController.m
//  FinalProject
//
//  Created by Michael on 5/1/15.
//  Copyright (c) 2015 Bokun Xu. All rights reserved.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface ViewController ()

@property (strong, nonatomic) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self myTimeline];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)myTimeline {
    ACAccountStore *account = [[ACAccountStore alloc] init];
    

    ACAccountType *typeOfAccount = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:typeOfAccount options:nil completion:^(BOOL granted, NSError *error) {
        
        if (granted == YES) {
            
            // get all twitter accounts into this array
            NSArray *arrayOfAccounts = [account accountsWithAccountType:typeOfAccount];
    
            // if there are more than 1 account, use the last one
            if ([arrayOfAccounts count] > 0) {
                ACAccount *twitterAcc = [arrayOfAccounts lastObject];
                
                // URL to api
                NSURL *requestAPI = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                
                // 50 tweets
                [parameters setObject:@"50" forKey:@"count"];
                [parameters setObject:@"1" forKey:@"include_entities"];
                
                
                // request and get object
                SLRequest *posts = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestAPI parameters:parameters];
                
                posts.account = twitterAcc;
                
                [posts performRequestWithHandler:^(NSData *response, NSHTTPURLResponse *urlResponse, NSError *error) {
                    self.array = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
                    
                    if (self.array.count != 0) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            // load data into tableview
                            [self.tableView reloadData];
                        });
                    }
                    
                }];
                
            }
            
        } else {
          
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Returns the number of rows for the table view using the array
    return [_array count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Creates each cell for the table view.
    
    static NSString *cellID =  @"CELLID" ;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    // Creates an NSDictionary that holds the user's posts and then loads the data into each cell of the table view.
    
    NSDictionary *tweet = _array[indexPath.row];
    cell.textLabel.text = tweet[@"text"];
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    // When a user selects a row this will deselect the row.
//    
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//}


@end









































