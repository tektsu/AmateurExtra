//
//  XMLParser.m
//  aecli
//
//  Created by Stephen Baker on 5/24/09.
//  Copyright 2009 America. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "XMLParser.h"


@implementation XMLParser

- (XMLParser *)initWithContext:(NSManagedObjectContext *)moc {
  self = [super init];
  context = moc;
  return self;
}

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
  
  if([elementName isEqualToString:@"question"]) {
    NSString *answerLetter = [attributeDict valueForKey:@"answer"];
    NSString *answer, *distractor1, *distractor2, *distractor3;
    if([answerLetter isEqualTo:@"A"]) {
      answer = [attributeDict valueForKey:@"A"];
      distractor1 = [attributeDict valueForKey:@"B"];
      distractor2 = [attributeDict valueForKey:@"C"];
      distractor3 = [attributeDict valueForKey:@"D"];
    }
    if([answerLetter isEqualTo:@"B"]) {
      answer = [attributeDict valueForKey:@"B"];
      distractor1 = [attributeDict valueForKey:@"A"];
      distractor2 = [attributeDict valueForKey:@"C"];
      distractor3 = [attributeDict valueForKey:@"D"];
    }
    if([answerLetter isEqualTo:@"C"]) {
      answer = [attributeDict valueForKey:@"C"];
      distractor1 = [attributeDict valueForKey:@"B"];
      distractor2 = [attributeDict valueForKey:@"A"];
      distractor3 = [attributeDict valueForKey:@"D"];
    }
    if([answerLetter isEqualTo:@"D"]) {
      answer = [attributeDict valueForKey:@"D"];
      distractor1 = [attributeDict valueForKey:@"B"];
      distractor2 = [attributeDict valueForKey:@"C"];
      distractor3 = [attributeDict valueForKey:@"A"];
    }
    NSLog(@"Question %@ (%@)", 
          [attributeDict valueForKey:@"id"], 
          [attributeDict valueForKey:@"answer"]);
    NSLog(@"%@", [attributeDict valueForKey:@"question"]);
    NSLog(@"A. %@", [attributeDict valueForKey:@"A"]);
    NSLog(@"B. %@", [attributeDict valueForKey:@"B"]);
    NSLog(@"C. %@", [attributeDict valueForKey:@"C"]);
    NSLog(@"D. %@", [attributeDict valueForKey:@"D"]);
    
    NSManagedObject *newQuestion = 
    [NSEntityDescription
     insertNewObjectForEntityForName:@"Question"
     inManagedObjectContext:context];
    [newQuestion setValue:[attributeDict objectForKey:@"id"] forKey:@"id"];
    [newQuestion setValue:[attributeDict objectForKey:@"question"] forKey:@"question"];
    [newQuestion setValue:answer forKey:@"answer"];
    [newQuestion setValue:distractor1 forKey:@"distractor1"];
    [newQuestion setValue:distractor2 forKey:@"distractor2"];
    [newQuestion setValue:distractor3 forKey:@"distractor3"];
  }  
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
  
}


@end
