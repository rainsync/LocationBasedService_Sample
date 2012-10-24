//
//  CampusPOIViewController.m
//  LBS_sample
//
//  Created by 승원 김 on 12. 10. 24..
//  Copyright (c) 2012년 승원 김. All rights reserved.
//

#import "CampusPOIViewController.h"
#import "AppDelegate.h"
#import "LSLibrary.h"
#import "LSRestaurant.h"
#import "LSPrinter.h"

@interface CampusPOIViewController (Private)
- (AppDelegate *)appDelegate;
- (void)refreshTitleRow;
@end

@implementation CampusPOIViewController
@synthesize libraryExpanded = _libraryExpanded, restaurantExpanded = _restaurantExpanded, printerExpanded = _printerExpanded;

- (AppDelegate *)appDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Campus POI";
        self.tabBarItem.image = [UIImage imageNamed:@"poi_view_tab_icon"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _libraryExpanded = _restaurantExpanded = _printerExpanded = NO;
    [self refreshTitleRow];
    [self addObserver:self forKeyPath:@"libraryExpanded" options:0 context:nil];
    [self addObserver:self forKeyPath:@"restaurantExpanded" options:0 context:nil];
    [self addObserver:self forKeyPath:@"printerExpanded" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"libraryExpanded"] |
        [keyPath isEqualToString:@"restaurantExpanded"] |
        [keyPath isEqualToString:@"printerExpanded"]) {
        [self refreshTitleRow];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)refreshTitleRow {
    _titleRow[0] = 0;
    if (_libraryExpanded) {
        _titleRow[1] = self.numOfLibrary + 1;
    } else {
        _titleRow[1] = _titleRow[0] + 1;
    }
    if (_restaurantExpanded) {
        _titleRow[2] = _titleRow[1] + self.numOfRestaurant + 1;
    } else {
        _titleRow[2] = _titleRow[1] + 1;
    }
}

// systhesize 가 아닌 수동으로 직접 액세스 메소드를 구현한다.
- (int)numOfLibrary
{
    return [[self appDelegate].libraryPOIs count];
}

- (int)numOfRestaurant
{
    return [[self appDelegate].restaurantPOIs count];
}

- (int)numOfPrinter
{
    return [[self appDelegate].printerPOIs count];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rowCount = 3;
    if (_libraryExpanded) {
        rowCount += self.numOfPrinter;
    }
    if (_restaurantExpanded) {
        rowCount += self.numOfRestaurant;
    }
    if (_printerExpanded) {
        rowCount += self.numOfRestaurant;
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int rowNum = indexPath.row;
    if (rowNum == _titleRow[0]){
        cell.textLabel.text = @"Library";
    }
    else if (_titleRow[0] < rowNum && rowNum < _titleRow[1]) {
        LSLibrary *currLibrary = [[self appDelegate].libraryPOIs objectAtIndex:(rowNum-1)];
        cell.textLabel.text = currLibrary.location;
    }
    else if (rowNum == _titleRow[1]) {
        cell.textLabel.text = @"Restaurant";
    }
    else if (_titleRow[1] < rowNum && rowNum < _titleRow[2]) {
        int index = rowNum - _titleRow[1];
        LSRestaurant *currRestaurant = [[self appDelegate].restaurantPOIs objectAtIndex:index-1];
        cell.textLabel.text = currRestaurant.restaurantName;
    }
    else if (rowNum == _titleRow[2]) {
        cell.textLabel.text = @"Printer";
    }
    else if (rowNum > _titleRow[2]) {
        int index = rowNum - _titleRow[2];
        LSPrinter *currPrinter = [[self appDelegate].printerPOIs objectAtIndex:index-1];
        cell.textLabel.text = currPrinter.location;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LSLocation *selectedPOI;
    int rowNum = indexPath.row;
    if (rowNum == _titleRow[0]) {
        // 테이블 뷰의 셀 개수를 가지는 rowCount는 기본적으로 추가된 POI 제목 셀의 개수인 3을 기본으로, 목록이 펼쳐진 POI의 항목 개수를 더해서 전체 row의 개수를 리턴한다.
        self.libraryExpanded = !self.libraryExpanded;
        return;
    }
    else if (_titleRow[0] < rowNum && rowNum < _titleRow[1]) {
        // 요청된 indexPath의 row 값을 읽어서 POI 제목 셀인지 POI 항목 셀인지를 판단한 뒤, POI 제목 셀이면 그냥 POI 종류를 나타내는 문자열을 넣어준다
        selectedPOI = [[self appDelegate].libraryPOIs objectAtIndex:(rowNum-1)];
    }
    else if (rowNum == _titleRow[1]) {
        // POI 항목 셀이면 해당 항복을 읽어낸 뒤 항목의 이름이나 위치값을 넣어준다.
        self.restaurantExpanded = !self.restaurantExpanded;
        return;
    }
    else if (_titleRow[1] < rowNum && rowNum < _titleRow[2]) {
        int index = rowNum - _titleRow[1];
        selectedPOI = [[self appDelegate].restaurantPOIs objectAtIndex:index-1];
    }
    else if (rowNum == _titleRow[2]) {
        self.printerExpanded = !self.printerExpanded;
        return;
    }
    else if (rowNum > _titleRow[2]) {
        int index = rowNum - _titleRow[2];
        selectedPOI = [[self appDelegate].printerPOIs objectAtIndex:index-1];
    }
}


@end
