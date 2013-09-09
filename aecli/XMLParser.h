//
//  XMLParser.h
//  aecli
//
//  Created by Stephen Baker on 5/24/09.
//  Copyright 2009 America. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface XMLParser : NSObject {
  NSManagedObjectContext *context;
}

- (XMLParser *)initWithContext:(NSManagedObjectContext *)moc;

@end
