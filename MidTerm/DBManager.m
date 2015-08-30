//
//  DBManager.m
//  MidTerm
//
//  Created by MCS on 8/29/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "DBManager.h"

@interface DBManager ()

@end

@implementation DBManager



- (void) connectionDB
{
    NSLog(@"This is the connection to the DataBase");
    
    // Do any additional setup after loading the view, typically from a nib.
    NSString * docDirectory;
    NSArray * dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSLog(@"%@", dirPaths);
    
    //get the path to the Data Base
    docDirectory = [dirPaths objectAtIndex:0];
    self.databasePath = [[NSString alloc]initWithString:[docDirectory stringByAppendingPathComponent:@"FavoritesTest.db"]];
    
    const char * dbPath = [self. databasePath UTF8String];
    
    if (sqlite3_open(dbPath, &sqlite3DB)==SQLITE_OK)
    {
        // Object to save errors
        char * errMsg;
        
        // Create DB
        const char * sql_stmt = "CREATE TABLE IF NOT EXISTS FAVORITES (ID INTEGER PRIMARY KEY AUTOINCREMENT, NEWS_NAME TEXT, DESCRIPTION TEXT, URL_LINK TEXT)";
        
        //Show error if can't create a table
        if ( !(sqlite3_exec(sqlite3DB, sql_stmt, NULL, NULL, &errMsg)))
        {
            NSLog(@" Table already Created ");
        }
        sqlite3_close(sqlite3DB);
    } else {
        NSLog(@"Failed to open/create DB");
    }
}

- (void) insertQuery : (NSString *) StringQuery;
{
    NSLog(@"%@", StringQuery);
    NSLog(@"This is the insert query function");
    
    //Create SQL Statement
    sqlite3_stmt * statement;
    const char * dbPath = [self.databasePath UTF8String];
    
    if ( sqlite3_open(dbPath, &sqlite3DB)==SQLITE_OK)
    {
        
        // Local Varibales to test the Insert
        NSString * StringName = @"News Name 5";
        NSString * StringDescription = @"News Description 5";
        NSString * StringURLLink = @"URL Link for the Original New 5";
        
        
        
        NSString * insertSQL = [NSString stringWithFormat:@"INSERT INTO FAVORITES (NEWS_NAME, DESCRIPTION, URL_LINK) VALUES (\"%@\", \"%@\", \"%@\")", StringName, StringDescription, StringURLLink];
        NSLog(@"%@", insertSQL);
        
        //Convert
        const char * insert_stmt = [insertSQL UTF8String];
        sqlite3_stmt * statement2;
        
        sqlite3_prepare_v2(sqlite3DB, insert_stmt, -1, &statement, NULL);
        
        if ( sqlite3_step(statement)==SQLITE_DONE)
        {
            NSLog( @"New Added to the DB ");
//            self.nameTextField.text = @"";
//            self.addressTextField.text = @"";
//            self.phoneTextField.text = @"";
        }
        else
        {
            NSLog( @"Failed to add Contact");
        }
        sqlite3_finalize(statement);
        sqlite3_close(sqlite3DB);
    }
}

- (void) selectQuery : (NSString *) StringQuery;
{
    NSLog(@"%@", StringQuery);
    NSLog(@"This is the select query function");
    
    sqlite3_stmt * statement;
    const char * dbPath = [self.databasePath UTF8String];
    
    //Open the Data Base
    if ( sqlite3_open(dbPath, &sqlite3DB)==SQLITE_OK)
    {
        NSString * querySQL = [NSString stringWithFormat:@"select * from FAVORITES"];
        NSLog(@"%@", querySQL);
        
        const char * query_stmt = [querySQL UTF8String];
        
        
        
        //Prepare de Query
        if ( sqlite3_prepare_v2(sqlite3DB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"SQL_OK -> %d", (sqlite3_prepare_v2(sqlite3DB, query_stmt, -1, &statement, NULL)));
            
            NSLog(@"Statement -> %d", sqlite3_step(statement));
            
            //If this worked, we must have a row if the data was there
            if ( sqlite3_open(dbPath, &sqlite3DB)==SQLITE_OK)
                NSLog(@"SQL Statement OK");
                {
                    do
                    {
                        //Prepare the SQL columns text to retrive the id
                        NSString * idField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                        NSLog(@"%@", idField);
                
                        //Parse the SQL column text to retrive the Name
                        NSString * NameField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                        NSLog(@"%@", NameField );
                
                        //Parse the SQL column text to retrive the Description
                        NSString * DescriptionField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                        NSLog(@"%@", DescriptionField );
                
                        //Parse the SQL column text to retrive the URL LINK
                        NSString * URLLinkField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                        NSLog(@"%@", URLLinkField );
                
                        NSLog( @"*** Match Found ***");
                    }
                    while (sqlite3_step(statement)==SQLITE_ROW);
            }
//            else
//            {
//                // If we dont have a row - the data is not found
//                NSLog( @" Math not found" );
////                self.addressTextField.text = @"";
////                self.phoneTextField.text   = @"";
//                
//            }
        }
    }
    
}

- (void) deleteQuery : (NSString *) StringQuery;
{
    NSLog(@"%@", StringQuery);
    NSLog(@"This is the delete query function");
    
    //Create SQL Statement object
    sqlite3_stmt * statement;
    const char * dbPath = [self.databasePath UTF8String];
    
    //Open the Data Base
    if ( sqlite3_open(dbPath, &sqlite3DB)==SQLITE_OK)
    {
        
        //Local Variables for testing
        NSString * StringName = @"News Name 5";
        
        
        
        
        //Create the SQL statement to delete the data
        NSString * querySQL = [NSString stringWithFormat:@"DELETE FROM FAVORITES WHERE NEWS_NAME IS '%@'", StringName];
        NSLog(@"%@", querySQL);
        
        const char * query_stmt = [querySQL UTF8String];
        
        // Prepare the query
        if ( sqlite3_prepare_v2(sqlite3DB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement)==SQLITE_OK)
            {
//                self.addressTextField.text = @"";
//                self.phoneTextField.text   = @"";
                NSLog(@"Record Deleted");
            }
        }
        else
        {
            //If we don't have a row - data not found
            NSLog(@"Record not found");
//            self.addressTextField.text = @"";
//            self.phoneTextField.text   = @"";
        }
        sqlite3_finalize(statement);
        sqlite3_close(sqlite3DB);
    }
}

@end
