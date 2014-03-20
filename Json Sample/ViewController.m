//
//  ViewController.m
//  Json Sample
//
//  Created by Rajesh on 19/03/14.
//  Copyright (c) 2014 Rajesh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //--[self simpleJsonParsingGetMetod];
#warning set webservice url to "jsonUrlString" & parse GET or POST method in JSON before access methods
    NSLog(@"Add Webservice URL and call any one method below");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)simpleJsonParsingGetMetod
{
    
#warning set webservice url to "jsonUrlString" & parse GET or POST method in JSON before access methods
    //-- Convert string into URL
    NSString *jsonUrlString = [NSString stringWithFormat:@"demo.com/your_server_db_name/service/link"];
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //-- Send request to server
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"GET"]; //-- Request method GET/POST
    
    //-- Receive response from server
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //-- JSON Parsing with response data
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"Result = %@",result);
}

- (void)simpleJsonParsingPostMetod
{
    
#warning set webservice url to "jsonUrlString" & parse GET or POST method in JSON before access methods
    
    //-- Temp Initialized variables
    NSString *first_name;
    NSString *last_name;
    NSString *image_name;
    NSData *imageData;
    
    //-- Convert string into URL
    NSString *urlString = [NSString stringWithFormat:@"demo.com/your_server_db_name/service/link"];
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //-- Append data into posr url using following method
    NSMutableData *body = [NSMutableData data];
    
    
    //-- For Sending text
    
    //-- "firstname" is keyword form service
    //-- "first_name" is the text which we have to send
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"firstname"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",first_name] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //-- "lastname" is keyword form service
    //-- "last_name" is the text which we have to send
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"lastname"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",last_name] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //-- For sending image into service (send as imagedata)
    
    //-- "image_name" is file name of the image (we can set custom name)
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"file\"; filename=\"%@\"\r\n",image_name] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //-- Sending data into server through URL
    [request setHTTPBody:body];
    
    //-- Getting response form server
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //-- JSON Parsing with response data
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"Result = %@",result);
}


- (void)simpleJsonParsingAuthentication
{
    //-- Convert username & password with base64 encrypeion
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", @"username", @"password"];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    
    
#warning set webservice url to "jsonUrlString" & parse GET or POST method in JSON before access methods
    
    //-- Convert string into URL
    NSString *jsonUrlString = [NSString stringWithFormat:@"demo.com/your_server_db_name/service/link"];
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //-- Send request to server
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    //-- Send username & password for url authorization
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"]; //-- Request method GET/POST
    
    //-- Receive response from server
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //-- JSON Parsing with response data
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"Result = %@",result);
}

@end
